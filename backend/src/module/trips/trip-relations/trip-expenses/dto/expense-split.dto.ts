import { IsNotEmpty, IsNumber, IsString, Max, Min } from 'class-validator';

import { MAX_EXPENSE_AMOUNT } from './expense.constants';

export class ExpenseSplitDto {
  @IsString()
  @IsNotEmpty()
  tripMemberId!: string;

  @IsNumber({ maxDecimalPlaces: 2, allowNaN: false, allowInfinity: false })
  @Min(0)
  @Max(MAX_EXPENSE_AMOUNT)
  amount!: number;
}
