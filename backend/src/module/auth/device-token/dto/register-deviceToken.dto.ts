import { IsEnum, IsNotEmpty, IsString } from 'class-validator';
import { DevicePlatform } from '../../../../generated/prisma/browser';

export class RegisterDeviceTokenDto {
  @IsString()
  @IsNotEmpty()
  installationId!: string;

  @IsString()
  @IsNotEmpty()
  token!: string;

  @IsEnum(DevicePlatform)
  platform!: DevicePlatform;
}
