import {
  IsString,
  IsOptional,
  IsEnum,
  IsNumber,
  Length,
  IsNotEmpty,
  IsArray,
  ArrayUnique,
} from 'class-validator';
import { PLACE_CATEGORY } from '../../../generated/prisma/browser';

export class CreatePlaceDto {
  @IsString()
  @Length(1, 255)
  name!: string;
  @IsOptional()
  @IsString()
  description?: string;

  @IsArray()
  @IsString({ each: true })
  @IsNotEmpty({ each: true })
  @ArrayUnique()
  mediaIds!: string[];

  @IsEnum(PLACE_CATEGORY)
  category!: PLACE_CATEGORY;

  @IsString()
  @Length(1, 255)
  city!: string;

  @IsString()
  @Length(1, 255)
  country!: string;
  @IsString()
  @Length(1, 255)
  address!: string;
  @IsNumber()
  latitude!: number;
  @IsNumber()
  longitude!: number;
}
