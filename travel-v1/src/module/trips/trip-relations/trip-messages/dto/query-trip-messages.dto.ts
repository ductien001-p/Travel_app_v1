import { ApiPropertyOptional } from '@nestjs/swagger';

import { Type } from 'class-transformer';

import { IsInt, IsOptional, IsString, Max, Min } from 'class-validator';

export class QueryTripMessagesDto {
  @ApiPropertyOptional({
    minimum: 1,
    maximum: 100,
    default: 50,
  })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(100)
  limit: number = 50;

  @ApiPropertyOptional({
    description: 'Opaque cursor returned by the previous response',
  })
  @IsOptional()
  @IsString()
  cursor?: string;
}
