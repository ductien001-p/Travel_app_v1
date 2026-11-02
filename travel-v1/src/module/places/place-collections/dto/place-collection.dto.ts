import {
  ArrayNotEmpty,
  ArrayUnique,
  IsArray,
  IsEnum,
  IsInt,
  IsOptional,
  IsString,
  Length,
  Max,
  Min,
} from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { PlaceCollectionVisibility } from '../../../../generated/prisma/enums';

export class CreatePlaceCollectionDto {
  @ApiProperty({ minLength: 1, maxLength: 80 })
  @IsString()
  @Length(1, 80)
  title!: string;
}

export class UpdatePlaceCollectionDto {
  @ApiPropertyOptional({ minLength: 1, maxLength: 80 })
  @IsOptional()
  @IsString()
  @Length(1, 80)
  title?: string;

  @ApiPropertyOptional({ enum: PlaceCollectionVisibility })
  @IsOptional()
  @IsEnum(PlaceCollectionVisibility)
  visibility?: PlaceCollectionVisibility;
}

export class PlaceMembershipDto {
  @ApiProperty({ type: [String], minItems: 1 })
  @IsArray()
  @ArrayNotEmpty()
  @ArrayUnique()
  @IsString({ each: true })
  collectionIds!: string[];
}

export class RatePlaceCollectionDto {
  @ApiProperty({ minimum: 1, maximum: 5 })
  @IsInt()
  @Min(1)
  @Max(5)
  rating!: number;
}
