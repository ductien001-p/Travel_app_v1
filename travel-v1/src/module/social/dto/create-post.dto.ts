import {
  ArrayMaxSize,
  ArrayMinSize,
  IsArray,
  IsEnum,
  IsOptional,
  IsString,
  MaxLength,
} from 'class-validator';
import { SocialPostVisibility } from '../../../generated/prisma/enums';

export class CreatePostDto {
  @IsString()
  @MaxLength(1000)
  caption!: string;

  @IsOptional()
  @IsString()
  placeId?: string;

  @IsOptional()
  @IsEnum(SocialPostVisibility)
  visibility?: SocialPostVisibility;

  @IsArray()
  @ArrayMinSize(1)
  @ArrayMaxSize(10)
  @IsString({ each: true })
  mediaIds!: string[];
}
