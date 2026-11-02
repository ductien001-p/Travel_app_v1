import { Body, Controller, Delete, Post } from '@nestjs/common';
import { ApiCreatedResponse, ApiOkResponse } from '@nestjs/swagger';
import { RegisterDeviceTokenDto } from './dto/register-deviceToken.dto';
import { DeviceTokenService } from './device-token.service';
import { CurrentUser } from '../../../decoration/currentUser.decoration';
import { UnregisterDeviceDto } from './dto/unregister-deviseToken.dto';
import {
  DeviceTokenResponseDto,
  SuccessResponseDto,
} from '../../../common/contracts/extended-response.dto';

@Controller('device-tokens')
export class DeviceTokenController {
  constructor(private readonly deviceTokenService: DeviceTokenService) {}

  @Post()
  @ApiCreatedResponse({ type: DeviceTokenResponseDto })
  register(
    @CurrentUser('id') userId: string,
    @Body() dto: RegisterDeviceTokenDto,
  ) {
    return this.deviceTokenService.register(userId, dto);
  }

  @Delete('current')
  @ApiOkResponse({ type: SuccessResponseDto })
  unregister(
    @CurrentUser('id') userId: string,
    @Body() dto: UnregisterDeviceDto,
  ) {
    return this.deviceTokenService.unregister(userId, dto.installationId);
  }
}
