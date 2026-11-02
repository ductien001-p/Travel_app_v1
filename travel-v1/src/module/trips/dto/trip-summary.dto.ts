import { ApiProperty } from '@nestjs/swagger';

export class TripSummaryDto {
  @ApiProperty()
  total!: number;

  @ApiProperty()
  upcoming!: number;

  @ApiProperty()
  ongoing!: number;

  @ApiProperty()
  completed!: number;

  @ApiProperty()
  cancelled!: number;

  @ApiProperty({
    description: 'Trips whose backend status is NOTCOM, if that status exists',
  })
  notCompleted!: number;

  @ApiProperty({
    description: 'Total check-ins made by the authenticated user',
  })
  totalCheckins!: number;
}
