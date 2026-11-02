import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
  Logger,
} from '@nestjs/common';
import { Request, Response } from 'express';
import { Prisma } from '../../generated/prisma/client';
import {
  ApiErrorDetailDto,
  ApiErrorResponseDto,
} from '../contracts/api-error.dto';

const HTTP_ERROR_CODES: Partial<Record<number, string>> = {
  400: 'BAD_REQUEST',
  401: 'UNAUTHORIZED',
  403: 'FORBIDDEN',
  404: 'NOT_FOUND',
  409: 'CONFLICT',
  429: 'RATE_LIMITED',
};

@Catch()
export class ApiExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger(ApiExceptionFilter.name);

  catch(exception: unknown, host: ArgumentsHost): void {
    const http = host.switchToHttp();
    const request = http.getRequest<Request>();
    const response = http.getResponse<Response>();
    const error = this.normalize(exception);

    if (error.statusCode === 500) {
      if (exception instanceof Error) {
        this.logger.error(
          `Unhandled request error: ${exception.message}`,
          exception.stack,
        );
      } else {
        this.logger.error('Unhandled request error', String(exception));
      }
    }

    response.status(error.statusCode).json({
      ...error,
      timestamp: new Date().toISOString(),
      path: request.originalUrl || request.url,
    } satisfies ApiErrorResponseDto);
  }

  private normalize(
    exception: unknown,
  ): Omit<ApiErrorResponseDto, 'timestamp' | 'path'> {
    if (exception instanceof Prisma.PrismaClientKnownRequestError) {
      return this.normalizePrisma(exception);
    }

    if (
      exception instanceof HttpException ||
      (typeof exception === 'object' &&
        exception !== null &&
        'getStatus' in exception &&
        typeof exception.getStatus === 'function' &&
        'getResponse' in exception &&
        typeof exception.getResponse === 'function')
    ) {
      const httpException = exception as HttpException;
      const statusCode = httpException.getStatus();
      if (statusCode >= 500) {
        return {
          statusCode,
          code: 'INTERNAL_ERROR',
          message: 'Internal server error',
          details: [],
        };
      }
      const body = httpException.getResponse();
      const bodyObject = typeof body === 'object' && body !== null ? body : {};
      const rawMessage = 'message' in bodyObject ? bodyObject.message : body;

      if (statusCode === 400 && Array.isArray(rawMessage)) {
        return {
          statusCode,
          code: 'VALIDATION_ERROR',
          message: 'Validation failed',
          details: rawMessage.map((message) =>
            this.validationDetail(String(message)),
          ),
        };
      }

      const meta = this.domainErrorMeta(bodyObject);
      return {
        statusCode,
        code:
          ('code' in bodyObject && typeof bodyObject.code === 'string'
            ? bodyObject.code
            : HTTP_ERROR_CODES[statusCode]) ?? 'HTTP_ERROR',
        message:
          typeof rawMessage === 'string'
            ? rawMessage
            : httpException.message || 'Request failed',
        details: [],
        ...(meta ? { meta } : {}),
      };
    }

    return {
      statusCode: 500,
      code: 'INTERNAL_ERROR',
      message: 'Internal server error',
      details: [],
    };
  }

  private normalizePrisma(
    exception: Prisma.PrismaClientKnownRequestError,
  ): Omit<ApiErrorResponseDto, 'timestamp' | 'path'> {
    if (exception.code === 'P2002') {
      return {
        statusCode: 409,
        code: 'UNIQUE_CONSTRAINT',
        message: 'Resource already exists',
        details: [],
      };
    }
    if (exception.code === 'P2025') {
      return {
        statusCode: 404,
        code: 'RESOURCE_NOT_FOUND',
        message: 'Resource not found',
        details: [],
      };
    }
    if (exception.code === 'P2003') {
      return {
        statusCode: 409,
        code: 'FOREIGN_KEY_CONSTRAINT',
        message: 'Related resource is in use or does not exist',
        details: [],
      };
    }
    if (exception.code === 'P2000' || exception.code === 'P2011') {
      return {
        statusCode: 400,
        code: 'INVALID_DATABASE_VALUE',
        message: 'Invalid request data',
        details: [],
      };
    }
    return {
      statusCode: 500,
      code: 'DATABASE_ERROR',
      message: 'Internal server error',
      details: [],
    };
  }

  /** Domain errors (4xx only) may attach a plain `details` object as context. */
  private domainErrorMeta(body: object): Record<string, unknown> | undefined {
    if (!('details' in body)) return undefined;
    const { details } = body;
    if (typeof details !== 'object' || details === null) return undefined;
    if (Array.isArray(details)) return undefined;
    return details as Record<string, unknown>;
  }

  private validationDetail(message: string): ApiErrorDetailDto {
    return { field: message.split(' ')[0] || 'request', message };
  }
}
