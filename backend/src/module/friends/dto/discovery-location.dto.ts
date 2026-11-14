import { ApiProperty } from '@nestjs/swagger';
import {
  IsBoolean,
  IsNumber,
  IsOptional,
  Max,
  Min,
} from 'class-validator';
import { Type } from 'class-transformer';

export class UpdateDiscoveryLocationDto {
  @ApiProperty({ example: 16.0544, minimum: -90, maximum: 90 })
  @Type(() => Number)
  @IsNumber()
  @Min(-90)
  @Max(90)
  lat!: number;

  @ApiProperty({ example: 108.2022, minimum: -180, maximum: 180 })
  @Type(() => Number)
  @IsNumber()
  @Min(-180)
  @Max(180)
  lng!: number;

  @ApiProperty({
    required: false,
    default: true,
    description: 'When true, the user appears in nearby Find Friends suggestions.',
  })
  @IsOptional()
  @IsBoolean()
  shareLocationForDiscovery?: boolean;
}

export class DiscoveryLocationResponseDto {
  @ApiProperty({ example: 16.0544, nullable: true })
  discoveryLat!: number | null;

  @ApiProperty({ example: 108.2022, nullable: true })
  discoveryLng!: number | null;

  @ApiProperty({ type: String, format: 'date-time', nullable: true })
  discoveryLocatedAt!: Date | null;

  @ApiProperty({ example: true })
  shareLocationForDiscovery!: boolean;
}

export class DiscoveryLocationEnvelopeResponseDto {
  @ApiProperty({ type: DiscoveryLocationResponseDto })
  data!: DiscoveryLocationResponseDto;

  @ApiProperty({ example: 'Discovery location updated successfully' })
  message!: string;
}
