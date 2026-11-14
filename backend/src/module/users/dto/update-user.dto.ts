import { OmitType, PartialType } from '@nestjs/swagger';
import { CreateUserDto } from './create-user.dto';
import {
  ArrayMaxSize,
  ArrayUnique,
  IsArray,
  IsBoolean,
  IsEnum,
  IsIn,
  IsOptional,
  IsString,
} from 'class-validator';
import { BudgetLevel } from '../../../generated/prisma/browser';
const LANGUAGE_CODES = ['vi', 'en', 'ja', 'ko', 'zh', 'fr'];

const INTEREST_CODES = [
  'food',
  'nature',
  'photography',
  'culture',
  'adventure',
  'beach',
  'mountains',
  'nightlife',
  'shopping',
  'history',
];

export class UpdateUserDto extends PartialType(
  OmitType(CreateUserDto, ['email', 'password'] as const),
) {
  @IsOptional()
  @IsBoolean()
  notificationEnabled?: boolean;

  @IsOptional()
  @IsBoolean()
  shareLocationForDiscovery?: boolean;

  @IsOptional()
  @IsEnum(BudgetLevel)
  budgetLevel?: BudgetLevel;

  @IsOptional()
  @IsArray()
  @ArrayUnique()
  @ArrayMaxSize(10)
  @IsString({ each: true })
  @IsIn(LANGUAGE_CODES, { each: true })
  languages?: string[];

  @IsOptional()
  @IsArray()
  @ArrayUnique()
  @ArrayMaxSize(20)
  @IsString({ each: true })
  @IsIn(INTEREST_CODES, { each: true })
  interests?: string[];
}
