import { IsNotEmpty, IsString } from 'class-validator';

export class UnregisterDeviceDto {
  @IsString()
  @IsNotEmpty()
  installationId!: string;
}
