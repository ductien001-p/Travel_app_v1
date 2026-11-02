import { readFileSync } from 'node:fs';
import { join } from 'node:path';

type Schema = {
  $ref?: string;
  type?: string;
  format?: string;
  nullable?: boolean;
  enum?: unknown[];
  required?: string[];
  properties?: Record<string, Schema>;
  items?: Schema;
  additionalProperties?: boolean | Schema;
  allOf?: Schema[];
  oneOf?: Schema[];
  anyOf?: Schema[];
};

type OpenApiDocument = {
  paths: Record<string, Record<string, any>>;
  components: { schemas: Record<string, Schema> };
};

const document = JSON.parse(
  readFileSync(join(process.cwd(), 'contracts/openapi.json'), 'utf8'),
) as OpenApiDocument;

function dereference(schema: Schema): Schema {
  if (!schema.$ref) return schema;
  const name = schema.$ref.split('/').at(-1)!;
  const resolved = document.components.schemas[name];
  if (!resolved) throw new Error(`Unresolved OpenAPI schema: ${schema.$ref}`);
  return dereference(resolved);
}

function merged(schema: Schema): Schema {
  const resolved = dereference(schema);
  if (!resolved.allOf?.length) return resolved;
  const parts = resolved.allOf.map((part) => merged(part));
  return {
    ...resolved,
    type: resolved.type ?? 'object',
    properties: Object.assign(
      {},
      ...parts.map((part) => part.properties ?? {}),
      resolved.properties ?? {},
    ),
    required: [
      ...new Set(
        parts
          .flatMap((part) => part.required ?? [])
          .concat(resolved.required ?? []),
      ),
    ],
    allOf: undefined,
  };
}

function validate(
  schemaInput: Schema,
  value: unknown,
  location = '$',
): string[] {
  const schema = merged(schemaInput);
  if (value === null)
    return schema.nullable ? [] : [`${location}: null is not allowed`];
  if (schema.enum && !schema.enum.includes(value))
    return [`${location}: value is outside enum`];

  if (schema.oneOf || schema.anyOf) {
    const alternatives = schema.oneOf ?? schema.anyOf ?? [];
    const valid = alternatives.filter(
      (candidate) => validate(candidate, value, location).length === 0,
    );
    if (
      (schema.oneOf && valid.length !== 1) ||
      (schema.anyOf && valid.length === 0)
    ) {
      return [`${location}: union schema mismatch`];
    }
    return [];
  }

  if (schema.type === 'object' || schema.properties) {
    if (typeof value !== 'object' || Array.isArray(value))
      return [`${location}: expected object`];
    const record = value as Record<string, unknown>;
    const errors: string[] = [];
    for (const required of schema.required ?? []) {
      if (!(required in record))
        errors.push(`${location}.${required}: required field is missing`);
    }
    const properties = schema.properties ?? {};
    if (
      Object.keys(properties).length &&
      schema.additionalProperties !== true
    ) {
      for (const key of Object.keys(record)) {
        if (!(key in properties))
          errors.push(`${location}.${key}: field is not declared in OpenAPI`);
      }
    }
    for (const [key, child] of Object.entries(properties)) {
      if (key in record)
        errors.push(...validate(child, record[key], `${location}.${key}`));
    }
    return errors;
  }

  if (schema.type === 'array') {
    if (!Array.isArray(value)) return [`${location}: expected array`];
    return value.flatMap((item, index) =>
      validate(schema.items ?? {}, item, `${location}[${index}]`),
    );
  }
  if (schema.type === 'string') {
    if (typeof value !== 'string') return [`${location}: expected string`];
    if (schema.format === 'date-time' && Number.isNaN(Date.parse(value))) {
      return [`${location}: expected ISO-8601 date-time`];
    }
  }
  if (schema.type === 'number' && typeof value !== 'number')
    return [`${location}: expected number`];
  if (
    schema.type === 'integer' &&
    (typeof value !== 'number' || !Number.isInteger(value))
  ) {
    return [`${location}: expected integer`];
  }
  if (schema.type === 'boolean' && typeof value !== 'boolean')
    return [`${location}: expected boolean`];
  return [];
}

export function expectOpenApiResponse(
  method: string,
  path: string,
  status: number,
  body: unknown,
): void {
  const operation = document.paths[path]?.[method.toLowerCase()];
  expect(operation).toBeDefined();
  const response = operation.responses[String(status)];
  expect(response).toBeDefined();
  const schema = response.content?.['application/json']?.schema as
    Schema | undefined;
  expect(schema).toBeDefined();
  expect(validate(schema!, body)).toEqual([]);
}

export function expectErrorSchema(body: unknown): void {
  expect(
    validate({ $ref: '#/components/schemas/ApiErrorResponseDto' }, body),
  ).toEqual([]);
}
