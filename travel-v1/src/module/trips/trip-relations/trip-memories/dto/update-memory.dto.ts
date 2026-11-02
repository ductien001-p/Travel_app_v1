import { IsOptional, IsString, MaxLength } from 'class-validator';

export class UpdateMemoryDto {
  @IsOptional()
  @IsString()
  @MaxLength(1000)
  caption?: string;

  /**
   * @deprecated The media of a memory cannot be changed. Accepted only so
   * clients that resend the create payload keep working; it is ignored.
   */
  @IsOptional()
  @IsString()
  mediaId?: string;
}
