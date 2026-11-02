import { Type } from 'class-transformer';
import { IsIn, IsInt, IsNumber, IsOptional, Max, Min } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class FeaturedPlacesQueryDto {
  @ApiPropertyOptional({ minimum: -840, maximum: 840, default: 0 })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(-840)
  @Max(840)
  utcOffsetMinutes: number = 0;
}

export class NearbyPlacesQueryDto {
  @ApiProperty({ minimum: -90, maximum: 90 })
  @Type(() => Number)
  @IsNumber()
  @Min(-90)
  @Max(90)
  latitude!: number;

  @ApiProperty({ minimum: -180, maximum: 180 })
  @Type(() => Number)
  @IsNumber()
  @Min(-180)
  @Max(180)
  longitude!: number;

  @ApiProperty({ enum: [1, 5, 10] })
  @Type(() => Number)
  @IsIn([1, 5, 10])
  radiusKm!: number;
}
