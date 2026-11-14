import { ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsEnum,
  IsIn,
  IsNumber,
  IsOptional,
  IsString,
  Max,
  Min,
} from 'class-validator';
import { SocialPostTopic } from '../../../generated/prisma/enums';

export const SOCIAL_FEED_TABS = ['explore', 'following', 'nearby'] as const;
export type SocialFeedTab = (typeof SOCIAL_FEED_TABS)[number];

export class QuerySocialFeedDto {
  @ApiPropertyOptional({ enum: SOCIAL_FEED_TABS, default: 'explore' })
  @IsOptional()
  @IsIn(SOCIAL_FEED_TABS)
  tab: SocialFeedTab = 'explore';

  @ApiPropertyOptional({ enum: SocialPostTopic })
  @IsOptional()
  @IsEnum(SocialPostTopic)
  topic?: SocialPostTopic;

  @ApiPropertyOptional({ minimum: 1, default: 1 })
  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  @Min(1)
  page = 1;

  @ApiPropertyOptional({ minimum: 1, maximum: 50, default: 10 })
  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  @Min(1)
  @Max(50)
  limit = 10;

  @ApiPropertyOptional({ description: 'Required when tab=nearby' })
  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  lat?: number;

  @ApiPropertyOptional({ description: 'Required when tab=nearby' })
  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  lng?: number;
}
