import {
  Body,
  Controller,
  Delete,
  Get,
  Patch,
  Post,
  Put,
  UseGuards,
  Param,
} from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { TripInterestService } from './trip-interest.service';

import { SetTripInterestsDto } from './dto/setTripInterest.dto';

import { RolesGuard } from '../../../authorization/guard/roles.guard';

import { Roles } from '../../../../decoration/role.decoriation';

import { CreateInterestDto } from './dto/creatInterest.dto';

import { UpdateInterestDto } from './dto/updateInterest.dto';

import { Public } from '../../../../decoration/isPublic.decoration';

import { CurrentUser } from '../../../../decoration/currentUser.decoration';

import { USER_ROLE } from '../../../../generated/prisma/enums';

import { ApiStandardErrors } from '../../../../common/contracts/api-standard-errors.decorator';

import {
  InterestEnvelopeResponseDto,
  InterestsEnvelopeResponseDto,
  InterestActionResponseDto,
} from '../../../../common/contracts/extended-response.dto';

@ApiTags('Trip Interests')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trips/interests')
export class TripInterestsController {
  constructor(private readonly tripInterestService: TripInterestService) {}

  // =========================================================
  // GET ALL
  // =========================================================

  @Public()
  @Get('all')
  @ApiOkResponse({
    type: InterestsEnvelopeResponseDto,
  })
  async findAll() {
    const data = await this.tripInterestService.findAll();

    return {
      data,
      message: 'Interests retrieved successfully',
    };
  }

  // =========================================================
  // SET TRIP INTERESTS
  // =========================================================

  @Put(':tripId')
  @ApiOkResponse({
    type: InterestsEnvelopeResponseDto,
  })
  async setTripInterests(
    @Param('tripId') tripId: string,
    @Body() dto: SetTripInterestsDto,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripInterestService.setTripInterests(
      tripId,
      dto,
      userId,
    );

    return {
      data,
      message: 'Trip interests updated successfully',
    };
  }

  // =========================================================
  // CREATE
  // =========================================================

  @Post()
  @UseGuards(RolesGuard)
  @Roles(USER_ROLE.ADMIN)
  @ApiCreatedResponse({
    type: InterestEnvelopeResponseDto,
  })
  async create(@Body() dto: CreateInterestDto) {
    const data = await this.tripInterestService.create(dto);

    return {
      data,
      message: 'Interest created successfully',
    };
  }

  // =========================================================
  // UPDATE
  // =========================================================

  @Patch(':id')
  @UseGuards(RolesGuard)
  @Roles(USER_ROLE.ADMIN)
  @ApiOkResponse({
    type: InterestEnvelopeResponseDto,
  })
  async update(@Param('id') id: string, @Body() dto: UpdateInterestDto) {
    const data = await this.tripInterestService.update(id, dto);

    return {
      data,
      message: 'Interest updated successfully',
    };
  }

  // =========================================================
  // DELETE
  // =========================================================

  @Delete(':id')
  @UseGuards(RolesGuard)
  @Roles(USER_ROLE.ADMIN)
  @ApiOkResponse({
    type: InterestActionResponseDto,
  })
  async remove(@Param('id') id: string) {
    await this.tripInterestService.remove(id);

    return {
      success: true,
      message: 'Interest deleted successfully',
    };
  }
}
