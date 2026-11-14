import {
  IsIn,
  IsNotEmpty,
  IsOptional,
  IsString,
  MaxLength,
} from 'class-validator';
import { Transform } from 'class-transformer';
import { TRIP_MESSAGE_TYPE } from '../../../../../generated/prisma/browser';

/** SYSTEM messages are produced by the server only. */
export const CLIENT_MESSAGE_TYPES = [
  TRIP_MESSAGE_TYPE.TEXT,
  TRIP_MESSAGE_TYPE.IMAGE,
] as const;

export class SendTripMessageDto {
  @IsString()
  @IsNotEmpty()
  tripId!: string;

  @Transform(({ value }) => (typeof value === 'string' ? value.trim() : value))
  @IsString()
  @IsNotEmpty()
  @MaxLength(2000)
  content!: string;

  @IsOptional()
  @IsIn(CLIENT_MESSAGE_TYPES)
  messageType?: (typeof CLIENT_MESSAGE_TYPES)[number];
}
