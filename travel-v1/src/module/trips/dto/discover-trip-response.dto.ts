import { ApiProperty } from '@nestjs/swagger';
import { PaginationMetaDto } from '../../../common/contracts/pagination-meta.dto';
import { TripListItemDto } from './trip-list-item.dto';

export class DiscoverTripListItemDto extends TripListItemDto {
  @ApiProperty({
    nullable: true,
    minimum: 0,
    maximum: 100,
    type: Number,
    description:
      'Personalized match from 0 to 100. Null when the viewer has no Travel DNA, budget, interests, or past trips.',
  })
  matchScore!: number | null;
}

export class DiscoverTripListResponseDto {
  @ApiProperty({ type: [DiscoverTripListItemDto] })
  data!: DiscoverTripListItemDto[];

  @ApiProperty({ type: PaginationMetaDto })
  meta!: PaginationMetaDto;
}
