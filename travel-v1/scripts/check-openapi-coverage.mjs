import { readFile, readdir } from 'node:fs/promises';
import path from 'node:path';
import ts from 'typescript';

const HTTP_DECORATORS = new Map([
  ['Get', 'get'],
  ['Post', 'post'],
  ['Put', 'put'],
  ['Patch', 'patch'],
  ['Delete', 'delete'],
]);

const walk = async (directory) => {
  const entries = await readdir(directory, { withFileTypes: true });
  const files = await Promise.all(
    entries.map((entry) => {
      const target = path.join(directory, entry.name);
      return entry.isDirectory() ? walk(target) : [target];
    }),
  );
  return files.flat();
};

const decoratorsOf = (node) =>
  ts.canHaveDecorators(node) ? (ts.getDecorators(node) ?? []) : [];

const decoratorCall = (decorator) =>
  ts.isCallExpression(decorator.expression) ? decorator.expression : undefined;

const decoratorName = (decorator) => {
  const expression =
    decoratorCall(decorator)?.expression ?? decorator.expression;
  return ts.isIdentifier(expression) ? expression.text : undefined;
};

// Routes hidden from Swagger on purpose (web pages, deep link files) are not
// part of the mobile contract.
const EXCLUDE_DECORATORS = new Set([
  'ApiExcludeController',
  'ApiExcludeEndpoint',
]);

const isExcluded = (decorators) =>
  decorators.some((decorator) =>
    EXCLUDE_DECORATORS.has(decoratorName(decorator)),
  );

const literalArgument = (decorator) => {
  const argument = decoratorCall(decorator)?.arguments[0];
  return argument && ts.isStringLiteralLike(argument) ? argument.text : '';
};

const joinRoute = (...segments) => {
  const joined = segments
    .filter(Boolean)
    .map((segment) => segment.replace(/^\/+|\/+$/g, ''))
    .filter(Boolean)
    .join('/');
  return `/${joined}`.replace(/:([A-Za-z0-9_]+)/g, '{$1}');
};

const controllerFiles = (await walk('src')).filter((file) =>
  file.endsWith('.controller.ts'),
);
const sourceOperations = [];

for (const file of controllerFiles) {
  const sourceText = await readFile(file, 'utf8');
  const source = ts.createSourceFile(
    file,
    sourceText,
    ts.ScriptTarget.Latest,
    true,
    ts.ScriptKind.TS,
  );

  for (const statement of source.statements) {
    if (!ts.isClassDeclaration(statement) || !statement.name) continue;
    const classDecorators = decoratorsOf(statement);
    const controllerDecorator = classDecorators.find(
      (decorator) => decoratorName(decorator) === 'Controller',
    );
    if (!controllerDecorator || isExcluded(classDecorators)) continue;
    const prefix = literalArgument(controllerDecorator);
    const classPublic = classDecorators.some(
      (decorator) => decoratorName(decorator) === 'Public',
    );

    for (const member of statement.members) {
      if (!ts.isMethodDeclaration(member)) continue;
      const decorators = decoratorsOf(member);
      const routeDecorator = decorators.find((decorator) =>
        HTTP_DECORATORS.has(decoratorName(decorator)),
      );
      if (!routeDecorator || isExcluded(decorators)) continue;
      const name = decoratorName(routeDecorator);
      const method = HTTP_DECORATORS.get(name);
      const methodName = ts.isIdentifier(member.name)
        ? member.name.text
        : member.name.getText(source);
      sourceOperations.push({
        method,
        route: joinRoute(prefix, literalArgument(routeDecorator)),
        controller: statement.name.text,
        controllerMethod: methodName,
        public:
          classPublic ||
          decorators.some((decorator) => decoratorName(decorator) === 'Public'),
        hasBody: member.parameters.some((parameter) =>
          decoratorsOf(parameter).some(
            (decorator) => decoratorName(decorator) === 'Body',
          ),
        ),
      });
    }
  }
}

const document = JSON.parse(await readFile('contracts/openapi.json', 'utf8'));
const openApiOperations = [];
for (const [route, pathItem] of Object.entries(document.paths ?? {})) {
  for (const [method, operation] of Object.entries(pathItem)) {
    if (!HTTP_DECORATORS.has(method[0].toUpperCase() + method.slice(1)))
      continue;
    openApiOperations.push({ method, route, operation });
  }
}

const key = ({ method, route }) => `${method.toUpperCase()} ${route}`;
const sourceByKey = new Map(
  sourceOperations.map((operation) => [key(operation), operation]),
);
const openApiByKey = new Map(
  openApiOperations.map((operation) => [key(operation), operation]),
);
const missing = sourceOperations.filter(
  (operation) => !openApiByKey.has(key(operation)),
);
const extra = openApiOperations.filter(
  (operation) => !sourceByKey.has(key(operation)),
);
const operationIds = new Map();
for (const { operation } of openApiOperations) {
  const entries = operationIds.get(operation.operationId) ?? [];
  entries.push(operation);
  operationIds.set(operation.operationId, entries);
}
const duplicateOperationIds = [...operationIds.entries()].filter(
  ([, operations]) => operations.length > 1,
);

const violations = [];
for (const sourceOperation of sourceOperations) {
  const documented = openApiByKey.get(key(sourceOperation))?.operation;
  if (!documented) continue;
  if (!documented.tags?.length)
    violations.push(`${key(sourceOperation)}: missing tag`);
  const effectiveSecurity = Object.hasOwn(documented, 'security')
    ? documented.security
    : document.security;
  const secured = effectiveSecurity?.some((item) => 'access-token' in item);
  if (!sourceOperation.public && !secured)
    violations.push(`${key(sourceOperation)}: missing bearer security`);
  if (sourceOperation.public && secured)
    violations.push(`${key(sourceOperation)}: public endpoint requires bearer`);
  if (
    sourceOperation.hasBody &&
    !documented.requestBody?.content?.['application/json']?.schema
  )
    violations.push(`${key(sourceOperation)}: request DTO has no schema`);
  const successResponses = Object.entries(documented.responses ?? {}).filter(
    ([status]) => /^2\d\d$/.test(status),
  );
  const explicitlyBodyless = successResponses.some(([, response]) =>
    /no (json|response) body/i.test(response.description ?? ''),
  );
  if (
    successResponses.length === 0 ||
    (!explicitlyBodyless &&
      !successResponses.some(
        ([, response]) => response.content?.['application/json']?.schema,
      ))
  ) {
    violations.push(`${key(sourceOperation)}: success response has no schema`);
  }
}

console.log(
  JSON.stringify(
    {
      sourceOperations: sourceOperations.length,
      openApiOperations: openApiOperations.length,
      coverage:
        sourceOperations.length === 0
          ? 100
          : Number(
              (
                ((sourceOperations.length - missing.length) /
                  sourceOperations.length) *
                100
              ).toFixed(2),
            ),
      missing: missing.map(key),
      extra: extra.map(key),
      duplicateOperationIds: duplicateOperationIds.map(([id]) => id),
      violations,
    },
    null,
    2,
  ),
);

if (missing.length || duplicateOperationIds.length || violations.length)
  process.exitCode = 1;
