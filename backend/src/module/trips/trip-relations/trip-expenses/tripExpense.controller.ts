import {
  Body,
  Controller,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  Post,
  Query,
} from '@nestjs/common';

import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';

import { CreateExpenseDto } from './dto/create-expense.dto';
import { PaginationDto } from '../../../users/dto/pagination.dto';

import { CurrentUser } from '../../../../decoration/currentUser.decoration';

import { TripExpenseService } from './tripExpense.service';

import { ApiStandardErrors } from '../../../../common/contracts/api-standard-errors.decorator';

import {
  TripExpenseEnvelopeResponseDto,
  TripExpenseOverviewEnvelopeResponseDto,
  TripExpenseSplitEnvelopeResponseDto,
} from '../../../../common/contracts/extended-response.dto';

@ApiTags('Trip Expenses')
@ApiBearerAuth('access-token')
@ApiStandardErrors()
@Controller('trips/:tripId/expenses')
export class TripExpenseController {
  constructor(private readonly tripExpenseService: TripExpenseService) {}

  @Get()
  @ApiOkResponse({
    type: TripExpenseOverviewEnvelopeResponseDto,
    description:
      'Group fund overview: totals, category shares, unsettled settlements, and one page of the expense feed. Summary, categories, and settlements cover every expense in the overview currency. Returns 404 when the caller has no active trip membership and 403 when the member lacks the required role.',
  })
  async getExpenses(
    @Param('tripId') tripId: string,
    @CurrentUser('id') userId: string,
    @Query() query: PaginationDto,
  ) {
    const data = await this.tripExpenseService.getExpenses(
      tripId,
      userId,
      query.page,
      query.limit,
    );
    return {
      data,
      message: 'Trip expenses retrieved successfully',
    };
  }

  @Post()
  @ApiCreatedResponse({
    type: TripExpenseEnvelopeResponseDto,
  })
  async createExpense(
    @Param('tripId') tripId: string,
    @Body() dto: CreateExpenseDto,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripExpenseService.createExpense(
      tripId,
      userId,
      dto,
    );

    return {
      data,
      message: 'Expense created successfully',
    };
  }

  @Post(':expenseId/splits/:splitId/settle')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({
    type: TripExpenseSplitEnvelopeResponseDto,
    description:
      'Marks one share as paid. Allowed for the expense payer and for the member who owes the share.',
  })
  async settleSplit(
    @Param('tripId') tripId: string,
    @Param('expenseId') expenseId: string,
    @Param('splitId') splitId: string,
    @CurrentUser('id') userId: string,
  ) {
    const data = await this.tripExpenseService.settleSplit(
      tripId,
      expenseId,
      splitId,
      userId,
    );

    return {
      data,
      message: 'Expense share settled successfully',
    };
  }
}
