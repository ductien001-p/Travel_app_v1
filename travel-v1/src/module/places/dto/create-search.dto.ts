import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  ArrayUnique,
  IsArray,
  IsEnum,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';
import { PLACE_CATEGORY } from '../../../generated/prisma/enums';

export class CreateSearchDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  query!: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  @IsNotEmpty()
  destinationId?: string;
  @IsOptional()
  @IsNumber()
  radiusKm?: number;

  @ApiPropertyOptional({ enum: PLACE_CATEGORY, isArray: true })
  @IsOptional()
  @IsArray()
  @ArrayUnique()
  @IsEnum(PLACE_CATEGORY, { each: true })
  categories?: PLACE_CATEGORY[];
}
