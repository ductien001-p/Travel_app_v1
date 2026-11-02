import { ApiProperty } from '@nestjs/swagger';

import { PaginationMetaDto } from '../../../common/contracts/pagination-meta.dto';

import { TripListItemDto } from './trip-list-item.dto';

import { TripSummaryDto } from './trip-summary.dto';

export class TripListResponseDto {
  @ApiProperty({
    type: [TripListItemDto],
  })
  data!: TripListItemDto[];

  @ApiProperty({
    type: PaginationMetaDto,
  })
  meta!: PaginationMetaDto;

  @ApiProperty({
    type: TripSummaryDto,
  })
  summary!: TripSummaryDto;
}
