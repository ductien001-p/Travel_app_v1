import { ArrayNotEmpty, IsArray, IsString } from 'class-validator';

export class DeleteGalleryDto {
  @IsArray()
  @IsString({ each: true })
  @ArrayNotEmpty()
  mediaIds!: string[];
}
