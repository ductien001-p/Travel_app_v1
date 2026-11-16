import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class PublicImageItemResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ format: 'uri' })
  imageUrl!: string;

  @ApiPropertyOptional({ nullable: true, type: String, format: 'uri' })
  thumbnailUrl!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  caption!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  cityLabel!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  locationLabel!: string | null;

  @ApiPropertyOptional({ nullable: true, type: String })
  locationShortLabel!: string | null;

  @ApiPropertyOptional({ nullable: true, type: Number })
  latitude!: number | null;

  @ApiPropertyOptional({ nullable: true, type: Number })
  longitude!: number | null;

  @ApiPropertyOptional({ nullable: true, type: String, format: 'date-time' })
  capturedAt!: string | null;

  @ApiProperty()
  likeCount!: number;

  @ApiProperty()
  commentCount!: number;

  @ApiProperty()
  likedByMe!: boolean;

  @ApiProperty()
  canSetAsCover!: boolean;

  @ApiProperty()
  canDelete!: boolean;
}

export class PublicImageAlbumResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  title!: string;

  @ApiProperty()
  tripTitle!: string;

  @ApiProperty({ type: [PublicImageItemResponseDto] })
  images!: PublicImageItemResponseDto[];
}

export class PublicImageAlbumEnvelopeResponseDto {
  @ApiProperty({ type: PublicImageAlbumResponseDto })
  data!: PublicImageAlbumResponseDto;

  @ApiProperty()
  message!: string;
}
