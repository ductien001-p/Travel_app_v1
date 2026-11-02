import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class FeaturedPlaceItemDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiPropertyOptional({ nullable: true })
  coverImageUrl!: string | null;

  @ApiProperty()
  category!: string;

  @ApiProperty()
  averageRating!: number;

  @ApiProperty()
  saveCount!: number;

  @ApiProperty()
  city!: string;

  @ApiProperty()
  address!: string;

  @ApiPropertyOptional({ nullable: true })
  description!: string | null;

  @ApiProperty()
  bookmarked!: boolean;
}

export class FeaturedPlacesDataDto {
  @ApiProperty({ example: 'Nổi bật hôm nay' })
  subtitle!: string;

  @ApiProperty({ example: '2026-10-31' })
  date!: string;

  @ApiProperty({ type: [FeaturedPlaceItemDto] })
  places!: FeaturedPlaceItemDto[];
}

export class FeaturedPlacesResponseDto {
  @ApiProperty({ type: FeaturedPlacesDataDto })
  data!: FeaturedPlacesDataDto;

  @ApiProperty()
  message!: string;
}

export class NearbyPlaceItemDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiPropertyOptional({ nullable: true })
  coverImageUrl!: string | null;

  @ApiProperty()
  category!: string;

  @ApiProperty()
  averageRating!: number;

  @ApiProperty()
  reviewCount!: number;

  @ApiProperty()
  address!: string;

  @ApiProperty()
  distanceMeters!: number;

  @ApiProperty({ enum: ['walk', 'drive'] })
  travelMode!: string;

  @ApiProperty()
  travelMinutes!: number;
}

export class NearbyPlacesResponseDto {
  @ApiProperty({ type: [NearbyPlaceItemDto] })
  data!: NearbyPlaceItemDto[];

  @ApiProperty()
  message!: string;
}
