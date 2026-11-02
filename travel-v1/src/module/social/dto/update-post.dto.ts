import {
  IsArray,
  IsEnum,
  IsOptional,
  IsString,
  MaxLength,
} from 'class-validator';
import { SocialPostVisibility } from '../../../generated/prisma/enums';

export class UpdatePostDto {
  @IsOptional()
  @IsString()
  @MaxLength(1000)
  caption?: string;

  @IsOptional()
  @IsString()
  placeId?: string | null;

  @IsOptional()
  @IsEnum(SocialPostVisibility)
  visibility?: SocialPostVisibility;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  mediaIds?: string[];
}
