import { IsEnum, IsOptional } from 'class-validator';

import { PaginationDto } from '../../../../users/dto/pagination.dto';
import { INVITATION_STATUS } from '../../../../../generated/prisma/enums';

export class GetReceivedInvitationsDto extends PaginationDto {
  /** Defaults to PENDING. */
  @IsOptional()
  @IsEnum(INVITATION_STATUS)
  status?: INVITATION_STATUS;
}
