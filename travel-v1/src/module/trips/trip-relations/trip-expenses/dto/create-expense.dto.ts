import {
  ArrayMaxSize,
  IsArray,
  IsDateString,
  IsEnum,
  IsNumber,
  IsOptional,
  IsPositive,
  IsString,
  Max,
  MaxLength,
  ValidateNested,
} from 'class-validator';

import { Type } from 'class-transformer';

import { ExpenseSplitDto } from './expense-split.dto';
import { MAX_EXPENSE_AMOUNT } from './expense.constants';
import {
  CURRENCY,
  EXPENSE_CATEGORY,
  EXPENSE_SPLIT_TYPE,
} from '../../../../../generated/prisma/browser';

export const MAX_EXPENSE_RECEIPTS = 5;

export class CreateExpenseDto {
  @IsNumber({ maxDecimalPlaces: 2, allowNaN: false, allowInfinity: false })
  @IsPositive()
  @Max(MAX_EXPENSE_AMOUNT)
  amount!: number;

  @IsEnum(CURRENCY)
  currency: CURRENCY = CURRENCY.VND;

  @IsEnum(EXPENSE_CATEGORY)
  category!: EXPENSE_CATEGORY;

  @IsEnum(EXPENSE_SPLIT_TYPE)
  splitType!: EXPENSE_SPLIT_TYPE;

  @IsOptional()
  @IsString()
  @MaxLength(500)
  description?: string;

  /**
   * Trip member id of who paid. Defaults to the authenticated member.
   */
  @IsOptional()
  @IsString()
  payerTripMemberId?: string;

  /**
   * When the money was spent (ISO-8601). Defaults to now.
   */
  @IsOptional()
  @IsDateString()
  spentAt?: string;

  @IsOptional()
  @IsString()
  @MaxLength(200)
  locationNote?: string;

  @IsOptional()
  @IsArray()
  @ArrayMaxSize(MAX_EXPENSE_RECEIPTS)
  @IsString({ each: true })
  receiptMediaIds?: string[];

  /**
   * Dùng cho CUSTOM
   */
  @IsOptional()
  @IsArray()
  @ArrayMaxSize(100)
  @ValidateNested({ each: true })
  @Type(() => ExpenseSplitDto)
  splits?: ExpenseSplitDto[];
}
