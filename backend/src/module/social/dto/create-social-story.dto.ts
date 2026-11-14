import { IsBoolean, IsOptional, IsString, MaxLength } from 'class-validator';

export class CreateSocialStoryDto {
  @IsString()
  mediaId!: string;

  @IsString()
  @MaxLength(80)
  label!: string;

  @IsOptional()
  @IsBoolean()
  isLive?: boolean;
}
