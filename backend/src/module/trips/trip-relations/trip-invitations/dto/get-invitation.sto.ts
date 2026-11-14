import { IsEnum, IsOptional, IsString } from 'class-validator';

import { PaginationDto } from '../../../../users/dto/pagination.dto';
import { INVITATION_STATUS } from '../../../../../generated/prisma/enums';

export class GetTripInvitationsDto extends PaginationDto {
  @IsString()
  tripId!: string;

  /** Defaults to PENDING. */
  @IsOptional()
  @IsEnum(INVITATION_STATUS)
  status?: INVITATION_STATUS;
}
