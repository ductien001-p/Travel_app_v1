import { Type } from 'class-transformer';
import { IsInt, IsOptional, IsString, Max, Min } from 'class-validator';
import { ApiPropertyOptional } from '@nestjs/swagger';

export class GetFriendMessagesQueryDto {
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
    description: 'Opaque message cursor returned by the previous request',
  })
  @IsOptional()
  @IsString()
  cursor?: string;
}
