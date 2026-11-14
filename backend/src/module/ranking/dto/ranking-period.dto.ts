import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsEnum, IsOptional } from 'class-validator';
import { PaginationDto } from '../../users/dto/pagination.dto';

export enum RankingPeriodQuery {
  WEEK = 'WEEK',
  MONTH = 'MONTH',
  SEASON = 'SEASON',
  ALL_TIME = 'ALL_TIME',
}

export class RankingLeaderboardQueryDto extends PaginationDto {
  @IsOptional()
  @IsEnum(RankingPeriodQuery)
  @ApiPropertyOptional({
    enum: RankingPeriodQuery,
    default: RankingPeriodQuery.ALL_TIME,
  })
  period: RankingPeriodQuery = RankingPeriodQuery.ALL_TIME;
}

export class RankingMeQueryDto {
  @IsOptional()
  @IsEnum(RankingPeriodQuery)
  @ApiPropertyOptional({
    enum: RankingPeriodQuery,
    default: RankingPeriodQuery.ALL_TIME,
  })
  period: RankingPeriodQuery = RankingPeriodQuery.ALL_TIME;
}
