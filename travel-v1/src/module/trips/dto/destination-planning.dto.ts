import { Type } from 'class-transformer';
import {
  IsEnum,
  IsInt,
  IsNumber,
  IsOptional,
  Max,
  Min,
  ValidateNested,
} from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { PLACE_CATEGORY } from '../../../generated/prisma/enums';

export enum CatalogPlaceSort {
  POPULAR = 'POPULAR',
}

export class CatalogPlacesQueryDto {
  @ApiPropertyOptional({ enum: CatalogPlaceSort })
  @IsOptional()
  @IsEnum(CatalogPlaceSort)
  sort?: CatalogPlaceSort;

  @ApiPropertyOptional({ enum: PLACE_CATEGORY })
  @IsOptional()
  @IsEnum(PLACE_CATEGORY)
  category?: PLACE_CATEGORY;

  @ApiPropertyOptional({ minimum: 1, maximum: 100, default: 20 })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(100)
  limit?: number;
}

export class CoordinateDto {
  @ApiProperty({ minimum: -90, maximum: 90 })
  @Type(() => Number)
  @IsNumber()
  @Min(-90)
  @Max(90)
  lat!: number;

  @ApiProperty({ minimum: -180, maximum: 180 })
  @Type(() => Number)
  @IsNumber()
  @Min(-180)
  @Max(180)
  lng!: number;
}

export class RoutePreviewDto {
  @ApiProperty({ type: CoordinateDto })
  @ValidateNested()
  @Type(() => CoordinateDto)
  origin!: CoordinateDto;

  @ApiProperty({ type: CoordinateDto })
  @ValidateNested()
  @Type(() => CoordinateDto)
  destination!: CoordinateDto;
}

export class DestinationCatalogItemDto {
  @ApiProperty() id!: string;
  @ApiProperty() name!: string;
  @ApiProperty() country!: string;
  @ApiProperty() lat!: number;
  @ApiProperty() lng!: number;
  @ApiPropertyOptional({ nullable: true }) type!: string | null;
  @ApiProperty({ type: [String] }) highlights!: string[];
  @ApiPropertyOptional({ nullable: true }) coverImageUrl!: string | null;
}

export class CatalogPlaceDto {
  @ApiProperty() id!: string;
  @ApiProperty() name!: string;
  @ApiProperty({ enum: PLACE_CATEGORY }) category!: PLACE_CATEGORY;
  @ApiPropertyOptional({ nullable: true }) description!: string | null;
  @ApiProperty() address!: string;
  @ApiProperty() latitude!: number;
  @ApiProperty() longitude!: number;
  @ApiPropertyOptional({ nullable: true }) averageRating!: number | null;
  @ApiProperty() reviewCount!: number;
  @ApiPropertyOptional({ nullable: true }) thumbnailUrl!: string | null;
  @ApiProperty() distanceKm!: number;
}

export class CatalogPlacesResultDto {
  @ApiProperty({ type: [CatalogPlaceDto] }) data!: CatalogPlaceDto[];
  @ApiProperty() total!: number;
  @ApiProperty({ enum: PLACE_CATEGORY, isArray: true })
  categories!: PLACE_CATEGORY[];
}

export class RoutePreviewResultDto {
  @ApiProperty() available!: boolean;
  @ApiPropertyOptional({ nullable: true }) distanceMeters!: number | null;
  @ApiPropertyOptional({ nullable: true }) durationSeconds!: number | null;
  @ApiPropertyOptional({ nullable: true }) polyline!: string | null;
  @ApiPropertyOptional({
    enum: ['MISSING_COORDINATES', 'PROVIDER_UNAVAILABLE'],
    nullable: true,
  })
  unavailableReason?: 'MISSING_COORDINATES' | 'PROVIDER_UNAVAILABLE';
}

export class DestinationCatalogResponseDto {
  @ApiProperty({ type: [DestinationCatalogItemDto] })
  data!: DestinationCatalogItemDto[];
  @ApiProperty() message!: string;
}

export class CatalogPlacesResponseDto {
  @ApiProperty({ type: CatalogPlacesResultDto }) data!: CatalogPlacesResultDto;
  @ApiProperty() message!: string;
}

export class RoutePreviewResponseDto {
  @ApiProperty({ type: RoutePreviewResultDto }) data!: RoutePreviewResultDto;
  @ApiProperty() message!: string;
}
