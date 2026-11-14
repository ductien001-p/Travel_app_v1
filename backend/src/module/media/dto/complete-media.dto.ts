import {
  IsArray,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Min,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
export class CompleteUploadDto {
  @IsString()
  @IsNotEmpty()
  objectKey!: string;

  @IsString()
  @IsNotEmpty()
  mimeType!: string;

  @IsOptional()
  @IsInt()
  @Min(0)
  fileSize?: number;

  @IsOptional()
  @IsInt()
  @Min(1)
  width?: number;

  @IsOptional()
  @IsInt()
  @Min(1)
  height?: number;
}

export class CompleteUploadMultipleDto {
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CompleteUploadDto)
  files!: CompleteUploadDto[];
}
