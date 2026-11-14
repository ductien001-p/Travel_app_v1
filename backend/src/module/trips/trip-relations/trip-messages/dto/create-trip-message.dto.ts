import {
  IsIn,
  IsNotEmpty,
  IsOptional,
  IsString,
  MaxLength,
} from 'class-validator';
import { Transform } from 'class-transformer';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { TRIP_MESSAGE_TYPE } from '../../../../../generated/prisma/browser';

export const HTTP_CLIENT_MESSAGE_TYPES = [
  TRIP_MESSAGE_TYPE.TEXT,
  TRIP_MESSAGE_TYPE.IMAGE,
] as const;

export class CreateTripMessageDto {
  @ApiProperty({
    description: 'Text body for TEXT; uploaded media id for IMAGE',
  })
  @Transform(({ value }) => (typeof value === 'string' ? value.trim() : value))
  @IsString()
  @IsNotEmpty()
  @MaxLength(2000)
  content!: string;

  @ApiPropertyOptional({
    enum: HTTP_CLIENT_MESSAGE_TYPES,
    default: TRIP_MESSAGE_TYPE.TEXT,
  })
  @IsOptional()
  @IsIn(HTTP_CLIENT_MESSAGE_TYPES)
  messageType?: (typeof HTTP_CLIENT_MESSAGE_TYPES)[number];

  @ApiPropertyOptional({
    description: 'Optional caption for IMAGE messages',
  })
  @IsOptional()
  @Transform(({ value }) => (typeof value === 'string' ? value.trim() : value))
  @IsString()
  @MaxLength(500)
  caption?: string;

  @ApiPropertyOptional({
    description: 'Optional location label for IMAGE messages',
  })
  @IsOptional()
  @Transform(({ value }) => (typeof value === 'string' ? value.trim() : value))
  @IsString()
  @MaxLength(200)
  locationLabel?: string;
}

export class TripMessageReactionDto {
  @ApiProperty({ example: '❤️' })
  @Transform(({ value }) => (typeof value === 'string' ? value.trim() : value))
  @IsString()
  @IsNotEmpty()
  @MaxLength(16)
  emoji!: string;
}
