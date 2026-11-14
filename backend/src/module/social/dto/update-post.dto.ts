import {
  IsArray,
  IsEnum,
  IsOptional,
  IsString,
  MaxLength,
} from 'class-validator';
import {
  SocialPostTopic,
  SocialPostVisibility,
} from '../../../generated/prisma/enums';

export class UpdatePostDto {
  @IsOptional()
  @IsString()
  @MaxLength(1000)
  caption?: string;

  @IsOptional()
  @IsString()
  placeId?: string | null;

  @IsOptional()
  @IsString()
  @MaxLength(200)
  placeDetail?: string | null;

  @IsOptional()
  @IsEnum(SocialPostVisibility)
  visibility?: SocialPostVisibility;

  @IsOptional()
  @IsEnum(SocialPostTopic)
  topic?: SocialPostTopic | null;

  @IsOptional()
  @IsString()
  @MaxLength(120)
  tipTitle?: string | null;

  @IsOptional()
  @IsString()
  @MaxLength(500)
  tipBody?: string | null;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  mediaIds?: string[];
}
