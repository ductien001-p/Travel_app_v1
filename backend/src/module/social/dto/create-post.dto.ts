import {
  ArrayMaxSize,
  ArrayMinSize,
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

export class CreatePostDto {
  @IsString()
  @MaxLength(1000)
  caption!: string;

  @IsOptional()
  @IsString()
  placeId?: string;

  @IsOptional()
  @IsString()
  @MaxLength(200)
  placeDetail?: string;

  @IsOptional()
  @IsEnum(SocialPostVisibility)
  visibility?: SocialPostVisibility;

  @IsOptional()
  @IsEnum(SocialPostTopic)
  topic?: SocialPostTopic;

  @IsOptional()
  @IsString()
  @MaxLength(120)
  tipTitle?: string;

  @IsOptional()
  @IsString()
  @MaxLength(500)
  tipBody?: string;

  @IsArray()
  @ArrayMinSize(1)
  @ArrayMaxSize(10)
  @IsString({ each: true })
  mediaIds!: string[];
}
