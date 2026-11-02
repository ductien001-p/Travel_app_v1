import { mkdir, writeFile } from 'node:fs/promises';
import { createRequire } from 'node:module';

const require = createRequire(import.meta.url);
const { NestFactory } = require('@nestjs/core');
const { DocumentBuilder, SwaggerModule } = require('@nestjs/swagger');
const {
  OpenApiModule,
  openApiControllers,
} = require('../dist/src/openapi/openapi.module.js');
const {
  ApiErrorResponseDto,
} = require('../dist/src/common/contracts/api-error.dto.js');
const {
  CursorMetaDto,
  PaginationMetaDto,
} = require('../dist/src/common/contracts/pagination-meta.dto.js');

const app = await NestFactory.create(OpenApiModule, { logger: false });
const config = new DocumentBuilder()
  .setTitle('Travel V1 Mobile API')
  .setDescription('Machine-readable contract for the Travel V1 Flutter client')
  .setVersion('1.0.0')
  .addBearerAuth(
    { type: 'http', scheme: 'bearer', bearerFormat: 'JWT' },
    'access-token',
  )
  .addSecurityRequirements('access-token')
  .build();

const document = SwaggerModule.createDocument(app, config, {
  extraModels: [ApiErrorResponseDto, PaginationMetaDto, CursorMetaDto],
});

// Authentication is global at runtime. Public handlers override the inherited
// bearer requirement with an empty security array in OpenAPI.
const publicOperationIds = new Set();
for (const controller of openApiControllers) {
  const classIsPublic = Reflect.getMetadata('isPublic', controller) === true;
  for (const methodName of Object.getOwnPropertyNames(controller.prototype)) {
    if (methodName === 'constructor') continue;
    const handler = controller.prototype[methodName];
    if (
      typeof handler === 'function' &&
      (classIsPublic || Reflect.getMetadata('isPublic', handler) === true)
    ) {
      publicOperationIds.add(`${controller.name}_${methodName}`);
    }
  }
}
for (const pathItem of Object.values(document.paths)) {
  for (const operation of Object.values(pathItem)) {
    if (publicOperationIds.has(operation.operationId)) operation.security = [];
  }
}

await mkdir('contracts', { recursive: true });
await writeFile(
  'contracts/openapi.json',
  `${JSON.stringify(document, null, 2)}\n`,
);
await app.close();
