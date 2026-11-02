import {
  IsArray,
  IsEnum,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Max,
  Min,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import { UploadFolder } from '../s3/upload-folder.type';

/** Allowed image Content-Type values for presigned PUT (must match client PUT header). */
export const PRESIGN_IMAGE_CONTENT_TYPES = [
  'image/jpeg',
  'image/jpg',
  'image/png',
  'image/gif',
  'image/webp',
] as const;

export class PresignFileDto {
  @IsString()
  @IsIn([...PRESIGN_IMAGE_CONTENT_TYPES])
  contentType!: string;
}
export class PresignUploadDto {
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => PresignFileDto)
  files!: PresignFileDto[];

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(60)
  @Max(86400)
  /** Presigned URL lifetime in seconds (default from env or 3600). */
  expiresInSeconds?: number;

  @IsString()
  @IsEnum(UploadFolder)
  folder!: UploadFolder;
}
