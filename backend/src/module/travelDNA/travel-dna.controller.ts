import { Controller, Get } from '@nestjs/common';

import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { TravelDnaService } from './travel-dna.service';

import { CurrentUser } from '../../decoration/currentUser.decoration';

import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';

import { TravelDnaEnvelopeResponseDto } from '../../common/contracts/extended-response.dto';
import { TravelDnaRadarEnvelopeResponseDto } from './travel-dna.response.dto';

@ApiTags('Travel DNA')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('travel-dna')
export class TravelDnaController {
  constructor(private readonly travelDnaService: TravelDnaService) {}

  @Get()
  @ApiOkResponse({
    type: TravelDnaEnvelopeResponseDto,
  })
  async getTravelDna(@CurrentUser('id') userId: string) {
    const data = await this.travelDnaService.getUserTravelDNA(userId);

    return {
      data,
      message: 'Travel DNA retrieved successfully',
    };
  }

  @Get('radar')
  @ApiOkResponse({
    type: TravelDnaRadarEnvelopeResponseDto,
  })
  async getRadar(@CurrentUser('id') userId: string) {
    const data = await this.travelDnaService.getRadar(userId);

    return {
      data,
      message: 'Travel DNA radar retrieved successfully',
    };
  }
}
