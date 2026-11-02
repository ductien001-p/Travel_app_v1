import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean } from 'class-validator';

export class UpdateJoinRequestSettingsDto {
  @ApiProperty({
    description: "Approve requests of the trip owner's friends without review",
  })
  @IsBoolean()
  autoApproveFriends!: boolean;
}
