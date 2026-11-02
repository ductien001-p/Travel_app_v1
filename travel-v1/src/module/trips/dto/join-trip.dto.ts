import { IsString, Length } from 'class-validator';

export class JoinTripDto {
  @IsString()
  @Length(6, 20)
  inviteCode!: string;
}
