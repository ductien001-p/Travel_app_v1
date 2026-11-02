import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class OwnedPlaceCollectionDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty({ enum: ['PRIVATE', 'PUBLIC'] })
  visibility!: string;

  @ApiProperty()
  placeCount!: number;

  @ApiProperty({ type: [String] })
  placeIds!: string[];
}

export class OwnedPlaceCollectionsResponseDto {
  @ApiProperty({ type: [OwnedPlaceCollectionDto] })
  data!: OwnedPlaceCollectionDto[];

  @ApiProperty()
  message!: string;
}

export class OwnedPlaceCollectionResponseDto {
  @ApiProperty({ type: OwnedPlaceCollectionDto })
  data!: OwnedPlaceCollectionDto;

  @ApiProperty()
  message!: string;
}

export class CollectionPlaceItemDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiPropertyOptional({ nullable: true })
  coverImageUrl!: string | null;

  @ApiProperty()
  category!: string;

  @ApiProperty()
  city!: string;

  @ApiProperty()
  averageRating!: number;
}

export class PlaceCollectionDetailDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty({ enum: ['PRIVATE', 'PUBLIC'] })
  visibility!: string;

  @ApiProperty()
  ownerDisplayName!: string;

  @ApiPropertyOptional({ nullable: true })
  coverImageUrl!: string | null;

  @ApiProperty()
  placeCount!: number;

  @ApiPropertyOptional({ nullable: true })
  averageRating!: number | null;

  @ApiProperty()
  ratingCount!: number;

  @ApiPropertyOptional({ nullable: true })
  viewerRating!: number | null;

  @ApiProperty()
  copiedByViewer!: boolean;

  @ApiProperty({ type: [CollectionPlaceItemDto] })
  places!: CollectionPlaceItemDto[];
}

export class PlaceCollectionDetailResponseDto {
  @ApiProperty({ type: PlaceCollectionDetailDto })
  data!: PlaceCollectionDetailDto;

  @ApiProperty()
  message!: string;
}

export class FeaturedCollectionItemDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  ownerDisplayName!: string;

  @ApiPropertyOptional({ nullable: true })
  coverImageUrl!: string | null;

  @ApiProperty()
  placeCount!: number;

  @ApiPropertyOptional({ nullable: true })
  averageRating!: number | null;

  @ApiProperty()
  ratingCount!: number;
}

export class FeaturedCollectionsResponseDto {
  @ApiProperty({ type: [FeaturedCollectionItemDto] })
  data!: FeaturedCollectionItemDto[];

  @ApiProperty()
  message!: string;
}

export class PlaceMembershipResultDto {
  @ApiProperty()
  placeId!: string;

  @ApiProperty({ type: [String] })
  collectionIds!: string[];

  @ApiProperty()
  saved!: boolean;
}

export class PlaceMembershipResponseDto {
  @ApiProperty({ type: PlaceMembershipResultDto })
  data!: PlaceMembershipResultDto;

  @ApiProperty()
  message!: string;
}

export class PlaceCollectionRatingResultDto {
  @ApiProperty()
  rating!: number;

  @ApiPropertyOptional({ nullable: true })
  averageRating!: number | null;

  @ApiProperty()
  ratingCount!: number;
}

export class PlaceCollectionRatingResponseDto {
  @ApiProperty({ type: PlaceCollectionRatingResultDto })
  data!: PlaceCollectionRatingResultDto;

  @ApiProperty()
  message!: string;
}

export class PlaceCollectionDeleteResponseDto {
  @ApiProperty()
  success!: boolean;

  @ApiProperty()
  message!: string;
}
