import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsBoolean,
  IsEnum,
  IsInt,
  IsOptional,
  IsString,
  Max,
  MaxLength,
  Min,
} from 'class-validator';
import {
  BudgetLevel,
  RECRUITMENT_ORIGIN,
} from '../../../../../generated/prisma/enums';

export class PatchRecruitmentDto {
  @ApiPropertyOptional({ maxLength: 2000 })
  @IsOptional()
  @IsString()
  @MaxLength(2000)
  requirements?: string;

  @ApiPropertyOptional({
    description: 'Per-person budget shown on the public post',
    example: '2400000',
  })
  @IsOptional()
  @IsString()
  estimatedBudgetPerPerson?: string;

  @ApiPropertyOptional({ minimum: 1, maximum: 3 })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(3)
  draftStep?: number;

  @ApiPropertyOptional({
    enum: [RECRUITMENT_ORIGIN.PUBLISH_WIZARD, RECRUITMENT_ORIGIN.EXISTING_TRIP],
  })
  @IsOptional()
  @IsEnum(RECRUITMENT_ORIGIN)
  origin?: RECRUITMENT_ORIGIN;

  @ApiPropertyOptional({ minimum: 1 })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  maxMembers?: number;

  @ApiPropertyOptional({ enum: BudgetLevel })
  @IsOptional()
  @IsEnum(BudgetLevel)
  budgetLevel?: BudgetLevel;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  acknowledgeRecruitmentImpact?: boolean;

  @ApiPropertyOptional({
    description: 'Show this post as urgent recruitment on destination feeds',
  })
  @IsOptional()
  @IsBoolean()
  urgent?: boolean;
}
