import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ApiErrorDetailDto {
  @ApiProperty({ example: 'email' })
  field!: string;

  @ApiProperty({ example: 'email must be an email' })
  message!: string;
}

export class ApiErrorResponseDto {
  @ApiProperty({ example: 400 })
  statusCode!: number;

  @ApiProperty({ example: 'VALIDATION_ERROR' })
  code!: string;

  @ApiProperty({ example: 'Validation failed' })
  message!: string;

  @ApiProperty({ type: [ApiErrorDetailDto] })
  details!: ApiErrorDetailDto[];

  @ApiPropertyOptional({
    type: 'object',
    additionalProperties: true,
    description: 'Structured context of a domain error, e.g. conflicting ids',
    example: { startDate: '2026-01-01', today: '2026-01-02' },
  })
  meta?: Record<string, unknown>;

  @ApiProperty({ format: 'date-time' })
  timestamp!: string;

  @ApiProperty({ example: '/users' })
  path!: string;
}
