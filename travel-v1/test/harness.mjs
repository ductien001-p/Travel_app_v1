import 'dotenv/config';
import { readFileSync, writeFileSync, appendFileSync, existsSync, mkdirSync } from 'node:fs';
import { join } from 'node:path';
import Redis from 'ioredis';
import { PrismaPg } from '@prisma/adapter-pg';
import { createRequire } from 'node:module';

const require = createRequire(import.meta.url);
const { PrismaClient } = require('../dist/src/generated/prisma/client.js');

const WORKFLOW_DIR = join(process.cwd(), '../.workflow/runtime-test');
const BASE_URL = 'http://localhost:3001';

// Load OpenAPI document
const openApiDoc = JSON.parse(
  readFileSync(join(process.cwd(), 'contracts/openapi.json'), 'utf8')
);

export const redis = new Redis({
  host: 'localhost',
  port: parseInt(process.env.REDIS_PORT || '6379'),
});

const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL });
export const prisma = new PrismaClient({ adapter });

function dereference(schema) {
  if (!schema || !schema.$ref) return schema;
  const name = schema.$ref.split('/').at(-1);
  const resolved = openApiDoc.components.schemas[name];
  if (!resolved) throw new Error(`Unresolved OpenAPI schema: ${schema.$ref}`);
  return dereference(resolved);
}

function merged(schema) {
  const resolved = dereference(schema);
  if (!resolved || !resolved.allOf?.length) return resolved;
  const parts = resolved.allOf.map((part) => merged(part));
  return {
    ...resolved,
    type: resolved.type ?? 'object',
    properties: Object.assign(
      {},
      ...parts.map((part) => part.properties ?? {}),
      resolved.properties ?? {}
    ),
    required: [
      ...new Set(
        parts
          .flatMap((part) => part.required ?? [])
          .concat(resolved.required ?? [])
      ),
    ],
    allOf: undefined,
  };
}

export function validateSchema(schemaInput, value, location = '$') {
  if (!schemaInput) return [];
  const schema = merged(schemaInput);
  if (value === null) {
    return schema.nullable ? [] : [`${location}: null is not allowed`];
  }
  if (schema.enum && !schema.enum.includes(value)) {
    return [`${location}: value ${JSON.stringify(value)} is outside enum [${schema.enum.join(', ')}]`];
  }

  if (schema.oneOf || schema.anyOf) {
    const alternatives = schema.oneOf ?? schema.anyOf ?? [];
    const valid = alternatives.filter(
      (candidate) => validateSchema(candidate, value, location).length === 0
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
    if (typeof value !== 'object' || Array.isArray(value)) {
      return [`${location}: expected object, got ${typeof value}`];
    }
    const record = value;
    const errors = [];
    for (const required of schema.required ?? []) {
      if (!(required in record)) {
        errors.push(`${location}.${required}: required field is missing`);
      }
    }
    const properties = schema.properties ?? {};
    for (const [key, child] of Object.entries(properties)) {
      if (key in record) {
        errors.push(...validateSchema(child, record[key], `${location}.${key}`));
      }
    }
    return errors;
  }

  if (schema.type === 'array') {
    if (!Array.isArray(value)) return [`${location}: expected array`];
    return value.flatMap((item, index) =>
      validateSchema(schema.items ?? {}, item, `${location}[${index}]`)
    );
  }
  if (schema.type === 'string') {
    if (typeof value !== 'string') return [`${location}: expected string`];
    if (schema.format === 'date-time' && Number.isNaN(Date.parse(value))) {
      return [`${location}: expected ISO-8601 date-time`];
    }
  }
  if (schema.type === 'number' && typeof value !== 'number') {
    return [`${location}: expected number`];
  }
  if (
    schema.type === 'integer' &&
    (typeof value !== 'number' || !Number.isInteger(value))
  ) {
    return [`${location}: expected integer`];
  }
  if (schema.type === 'boolean' && typeof value !== 'boolean') {
    return [`${location}: expected boolean`];
  }
  return [];
}

export function validateOpenApiResponse(method, route, status, body) {
  const openApiPath = route.replace(/:([A-Za-z0-9_]+)/g, '{$1}');
  const pathItem = openApiDoc.paths[openApiPath];
  if (!pathItem) return { valid: false, errors: [`Route not found in OpenAPI: ${openApiPath}`] };
  const operation = pathItem[method.toLowerCase()];
  if (!operation) return { valid: false, errors: [`Operation ${method} ${openApiPath} not in OpenAPI`] };
  const responseSpec = operation.responses[String(status)];
  if (!responseSpec) return { valid: false, errors: [`Response status ${status} not defined in OpenAPI for ${method} ${openApiPath}`] };
  const schema = responseSpec.content?.['application/json']?.schema;
  if (!schema) return { valid: true, errors: [] }; // No content or no json schema
  const errors = validateSchema(schema, body);
  return { valid: errors.length === 0, errors };
}

export function getState() {
  return JSON.parse(readFileSync(join(WORKFLOW_DIR, 'runtime-state.json'), 'utf8'));
}

export function updateState(updates) {
  const current = getState();
  const next = { ...current, ...updates, timestamp: new Date().toISOString() };
  writeFileSync(join(WORKFLOW_DIR, 'runtime-state.json'), JSON.stringify(next, null, 2));
}

export function getTestData() {
  return JSON.parse(readFileSync(join(WORKFLOW_DIR, 'test-data.json'), 'utf8'));
}

export function updateTestData(updates) {
  const current = getTestData();
  const merged = { ...current, ...updates };
  writeFileSync(join(WORKFLOW_DIR, 'test-data.json'), JSON.stringify(merged, null, 2));
}

export function getInventory() {
  return JSON.parse(readFileSync(join(WORKFLOW_DIR, 'endpoint-inventory.json'), 'utf8'));
}

export function updateInventoryEndpoint(taskId, updates) {
  const inv = getInventory();
  for (const phase in inv.endpoints) {
    const eps = inv.endpoints[phase].endpoints;
    if (eps) {
      const target = eps.find((e) => e.taskId === taskId);
      if (target) {
        Object.assign(target, updates);
        writeFileSync(join(WORKFLOW_DIR, 'endpoint-inventory.json'), JSON.stringify(inv, null, 2));
        return;
      }
    }
    const gws = inv.endpoints[phase].gateways;
    if (gws) {
      const target = gws.find((g) => g.taskId === taskId);
      if (target) {
        Object.assign(target, updates);
        writeFileSync(join(WORKFLOW_DIR, 'endpoint-inventory.json'), JSON.stringify(inv, null, 2));
        return;
      }
    }
  }
}

export async function request(method, path, { token, body, query, headers = {} } = {}) {
  let url = `${BASE_URL}${path}`;
  if (query) {
    const params = new URLSearchParams();
    for (const [k, v] of Object.entries(query)) {
      if (v !== undefined && v !== null) params.append(k, String(v));
    }
    const qStr = params.toString();
    if (qStr) url += `?${qStr}`;
  }

  const reqHeaders = { ...headers };
  if (token) {
    reqHeaders['Authorization'] = `Bearer ${token}`;
  }
  if (body !== undefined && !reqHeaders['Content-Type']) {
    reqHeaders['Content-Type'] = 'application/json';
  }

  const res = await fetch(url, {
    method,
    headers: reqHeaders,
    body: body !== undefined ? JSON.stringify(body) : undefined,
  });

  let data = null;
  const contentType = res.headers.get('content-type');
  if (contentType && contentType.includes('application/json')) {
    data = await res.json();
  } else {
    data = await res.text();
  }

  return {
    status: res.status,
    headers: res.headers,
    data,
  };
}

export function recordReport(phaseName, reportContent) {
  const reportDir = join(WORKFLOW_DIR, 'reports');
  if (!existsSync(reportDir)) mkdirSync(reportDir, { recursive: true });
  const filePath = join(reportDir, `${phaseName.toLowerCase()}.md`);
  appendFileSync(filePath, reportContent + '\n\n');
}

export function recordBlocker(blocker) {
  const filePath = join(WORKFLOW_DIR, 'blockers.md');
  const entry = `
### Blocker: ${blocker.taskId} - ${blocker.endpoint}
- **Severity**: ${blocker.severity}
- **Phase**: ${blocker.phase}
- **Reproduction**: ${blocker.reproduction}
- **Expected**: ${blocker.expected}
- **Actual**: ${blocker.actual}
- **Logs**: \`${blocker.logs || 'None'}\`
- **Likely Source**: ${blocker.likelySource || 'Unknown'}
- **Dependency Impact**: ${blocker.dependencyImpact}
- **Suggested Fix**: ${blocker.suggestedFix}
`;
  appendFileSync(filePath, entry);
}
