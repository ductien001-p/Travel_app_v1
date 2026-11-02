import { IsNotEmpty, IsString } from 'class-validator';

export class CreateTripInvitationDto {
  @IsString()
  @IsNotEmpty()
  tripId!: string;

  @IsString()
  @IsNotEmpty()
  inviteeId!: string;
}
