import {
  ArgumentsHost,
  BadRequestException,
  InternalServerErrorException,
} from '@nestjs/common';
import { ApiExceptionFilter } from './api-exception.filter';

describe('ApiExceptionFilter', () => {
  function setup(exception: unknown) {
    const json = jest.fn();
    const status = jest.fn().mockReturnValue({ json });
    const host = {
      switchToHttp: () => ({
        getRequest: () => ({ originalUrl: '/example' }),
        getResponse: () => ({ status }),
      }),
    } as unknown as ArgumentsHost;
    new ApiExceptionFilter().catch(exception, host);
    return { status, json };
  }

  it('returns field-aware validation errors', () => {
    const { status, json } = setup(
      new BadRequestException(['email must be an email']),
    );
    expect(status).toHaveBeenCalledWith(400);
    expect(json).toHaveBeenCalledWith(
      expect.objectContaining({
        code: 'VALIDATION_ERROR',
        message: 'Validation failed',
        path: '/example',
        details: [{ field: 'email', message: 'email must be an email' }],
      }),
    );
  });

  it('keeps the structured context of domain errors as meta', () => {
    const { json } = setup(
      new BadRequestException({
        code: 'TRIP_START_IN_PAST',
        message: 'Trip start date cannot be in the past',
        details: { startDate: '2026-01-01', today: '2026-01-02' },
      }),
    );
    expect(json).toHaveBeenCalledWith(
      expect.objectContaining({
        code: 'TRIP_START_IN_PAST',
        details: [],
        meta: { startDate: '2026-01-01', today: '2026-01-02' },
      }),
    );
  });

  it('does not expose unknown exception details', () => {
    const { json } = setup(new Error('database password leaked'));
    expect(json).toHaveBeenCalledWith(
      expect.objectContaining({
        statusCode: 500,
        code: 'INTERNAL_ERROR',
        message: 'Internal server error',
        details: [],
      }),
    );
  });

  it('sanitizes explicit 5xx HttpException messages', () => {
    const { json } = setup(
      new InternalServerErrorException('database password leaked'),
    );
    expect(json).toHaveBeenCalledWith(
      expect.objectContaining({
        statusCode: 500,
        code: 'INTERNAL_ERROR',
        message: 'Internal server error',
        details: [],
      }),
    );
  });
});
