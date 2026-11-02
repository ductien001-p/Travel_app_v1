import { readFile } from 'node:fs/promises';

const document = JSON.parse(await readFile('contracts/openapi.json', 'utf8'));
const schemas = document.components?.schemas ?? {};
const forbiddenResponseFields = new Set([
  'password',
  'hashedPassword',
  'passwordHash',
  'refreshTokenHash',
  'inviteCode',
  'secretAccessKey',
]);
// Owner-only responses that must expose a field forbidden everywhere else.
const allowedResponseFieldsBySchema = new Map([
  ['InviteCodeResponseDto', new Set(['inviteCode'])],
  // null unless the viewer is the trip owner.
  ['TripDetailResponseDto', new Set(['inviteCode'])],
]);

if (document.openapi !== '3.0.0' || !document.paths || !document.components) {
  throw new Error('Invalid OpenAPI root structure');
}

const schemaNameOf = (schema) => schema?.$ref?.split('/').at(-1);

const resolveSchema = (schema) => {
  if (!schema?.$ref) return schema;
  const name = schemaNameOf(schema);
  if (!schemas[name])
    throw new Error(`Unresolved schema reference: ${schema.$ref}`);
  return schemas[name];
};

const inspectResponseSchema = (schema, visited = new Set()) => {
  const resolved = resolveSchema(schema);
  if (!resolved || visited.has(resolved)) return;
  visited.add(resolved);
  const allowedFields = allowedResponseFieldsBySchema.get(schemaNameOf(schema));
  for (const [property, value] of Object.entries(resolved.properties ?? {})) {
    if (
      forbiddenResponseFields.has(property) &&
      !allowedFields?.has(property)
    ) {
      throw new Error(`Forbidden response property found: ${property}`);
    }
    inspectResponseSchema(value, visited);
    inspectResponseSchema(value.items, visited);
  }
  for (const child of [
    ...(resolved.allOf ?? []),
    ...(resolved.oneOf ?? []),
    ...(resolved.anyOf ?? []),
  ]) {
    inspectResponseSchema(child, visited);
  }
};

let operationCount = 0;
const operationIds = new Set();
const missingSuccessSchemas = [];
for (const [path, pathItem] of Object.entries(document.paths)) {
  for (const [method, operation] of Object.entries(pathItem)) {
    if (!['get', 'post', 'put', 'patch', 'delete'].includes(method)) continue;
    operationCount += 1;
    if (operationIds.has(operation.operationId))
      throw new Error(`Duplicate operationId: ${operation.operationId}`);
    operationIds.add(operation.operationId);
    if (!operation.tags?.length)
      throw new Error(`${method.toUpperCase()} ${path} has no tag`);
    if (!operation.responses || Object.keys(operation.responses).length === 0) {
      throw new Error(`${method.toUpperCase()} ${path} has no responses`);
    }
    for (const response of Object.values(operation.responses)) {
      const schema = response.content?.['application/json']?.schema;
      if (schema) inspectResponseSchema(schema);
    }
    const successResponses = Object.entries(operation.responses).filter(
      ([status]) => /^2\d\d$/.test(status),
    );
    const hasSchema = successResponses.some(
      ([, response]) => response.content?.['application/json']?.schema,
    );
    const explicitlyBodyless = successResponses.some(([, response]) =>
      /no (json|response) body/i.test(response.description ?? ''),
    );
    if (!hasSchema && !explicitlyBodyless)
      missingSuccessSchemas.push(`${method.toUpperCase()} ${path}`);
  }
}

if (missingSuccessSchemas.length) {
  throw new Error(
    `${missingSuccessSchemas.length} operations have no concrete success schema:\n${missingSuccessSchemas.join('\n')}`,
  );
}

const expectedResponses = [
  ['post', '/auth/login', '201', 'AuthTokensResponseDto'],
  ['post', '/auth/refresh', '201', 'SessionTokensResponseDto'],
  ['get', '/users/{id}', '200', 'PublicUserEnvelopeResponseDto'],
  ['get', '/trips/{id}', '200', 'TripDetailEnvelopeResponseDto'],
  [
    'post',
    '/trips/{tripId}/itineraries/days/{dayId}/activities',
    '201',
    'ActivityEnvelopeResponseDto',
  ],
  ['get', '/places/{id}', '200', 'PlaceEnvelopeResponseDto'],
  ['get', '/media/{id}', '200', 'MediaUrlEnvelopeResponseDto'],
];

for (const [method, path, status, schemaName] of expectedResponses) {
  const schema =
    document.paths[path]?.[method]?.responses?.[status]?.content?.[
      'application/json'
    ]?.schema;
  if (schema?.$ref !== `#/components/schemas/${schemaName}`) {
    throw new Error(
      `${method.toUpperCase()} ${path} does not use ${schemaName}`,
    );
  }
}

const loginOperation = document.paths['/auth/login']?.post;
if (
  loginOperation?.requestBody?.content?.['application/json']?.schema?.$ref !==
  '#/components/schemas/LoginDto'
) {
  throw new Error('POST /auth/login does not declare LoginDto request body');
}
if (!Array.isArray(loginOperation.security) || loginOperation.security.length) {
  throw new Error('POST /auth/login must be public');
}

for (const [method, path] of [
  ['get', '/users/me'],
  ['get', '/trips'],
  ['get', '/trips/{id}'],
]) {
  const security =
    document.paths[path]?.[method]?.security ?? document.security;
  if (!security?.some((requirement) => 'access-token' in requirement)) {
    throw new Error(
      `${method.toUpperCase()} ${path} must require access-token`,
    );
  }
}

console.log(
  JSON.stringify({
    openapi: document.openapi,
    operations: operationCount,
    schemas: Object.keys(schemas).length,
    status: 'valid',
  }),
);
