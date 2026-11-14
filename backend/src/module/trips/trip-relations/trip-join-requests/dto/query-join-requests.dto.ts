import { ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsEnum, IsInt, IsOptional, IsString, Max, Min } from 'class-validator';
import { JOIN_REQUEST_STATUS } from '../../../../../generated/prisma/enums';

export class QueryJoinRequestsDto {
  @ApiPropertyOptional({
    enum: JOIN_REQUEST_STATUS,
    default: JOIN_REQUEST_STATUS.PENDING,
  })
  @IsOptional()
  @IsEnum(JOIN_REQUEST_STATUS)
  status: JOIN_REQUEST_STATUS = JOIN_REQUEST_STATUS.PENDING;

  @ApiPropertyOptional({ minimum: 1, maximum: 50, default: 20 })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(50)
  limit: number = 20;

  /** Id of the last request of the previous page, for the same `status`. */
  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  cursor?: string;
}
