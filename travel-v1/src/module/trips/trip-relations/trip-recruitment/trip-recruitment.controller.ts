import {
  Body,
  Controller,
  Headers,
  HttpCode,
  HttpStatus,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { ApiStandardErrors } from '../../../../common/contracts/api-standard-errors.decorator';
import { CurrentUser } from '../../../../decoration/currentUser.decoration';
import { PatchRecruitmentDto } from './dto/patch-recruitment.dto';
import { RecruitmentPublishEnvelopeDto } from './dto/recruitment-response.dto';
import { TripRecruitmentService } from './trip-recruitment.service';

@ApiTags('Trips')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trips')
export class TripRecruitmentController {
  constructor(private readonly recruitment: TripRecruitmentService) {}

  @Patch(':tripId/recruitment')
  @ApiOkResponse({ type: RecruitmentPublishEnvelopeDto })
  async patch(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
    @Body() dto: PatchRecruitmentDto,
  ) {
    const data = await this.recruitment.patch(tripId, userId, dto);
    return { data, message: 'Recruitment updated successfully' };
  }

  @Post(':tripId/recruitment/publish')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: RecruitmentPublishEnvelopeDto })
  async publish(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
    @Headers('idempotency-key') idempotencyKey?: string,
  ) {
    const data = await this.recruitment.publish(
      userId,
      tripId,
      idempotencyKey,
    );
    return { data, message: 'Recruitment published successfully' };
  }

  @Post(':tripId/recruitment/close')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: RecruitmentPublishEnvelopeDto })
  async close(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.recruitment.close(tripId, userId);
    return { data, message: 'Recruitment closed successfully' };
  }

  @Post(':tripId/recruitment/reopen')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: RecruitmentPublishEnvelopeDto })
  async reopen(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.recruitment.reopen(tripId, userId);
    return { data, message: 'Recruitment reopened successfully' };
  }
}
