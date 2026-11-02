// dto/checkin.dto.ts
import { IsLatitude, IsLongitude } from 'class-validator';

export class CheckinDto {
  @IsLatitude()
  latitude!: number;

  @IsLongitude()
  longitude!: number;
}
