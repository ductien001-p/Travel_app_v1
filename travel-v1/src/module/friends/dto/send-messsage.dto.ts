import { IsNotEmpty, IsOptional, IsString, MaxLength } from 'class-validator';

export class SendFriendMessageDto {
  @IsString()
  @IsNotEmpty()
  @MaxLength(5000)
  content!: string;

  @IsOptional()
  @IsString()
  messageType?: string;
}
