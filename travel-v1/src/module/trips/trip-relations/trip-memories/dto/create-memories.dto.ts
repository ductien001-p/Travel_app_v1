import { IsOptional, IsString, MaxLength } from 'class-validator';

export class CreateMemoryDto {
  @IsOptional()
  @IsString()
  @MaxLength(1000)
  caption?: string;

  @IsString()
  mediaId!: string;
}
