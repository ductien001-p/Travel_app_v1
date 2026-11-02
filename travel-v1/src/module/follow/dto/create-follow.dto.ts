import { IsString } from 'class-validator';

export class CreateFollowDto {
  @IsString()
  followingId!: string;
}
