import { Body, Controller, Post, UseGuards, Request } from '@nestjs/common';
import { AuthService } from './auth.service';
import { Public } from '../../decoration/isPublic.decoration';
import { RefreshTokenDto } from './dto/refresh-token.dto';
import { RegisterDto } from './dto/register.dto';
import { CurrentUser } from '../../decoration/currentUser.decoration';
import { LocalAuthGuard } from './strategies/local-auth.guard';
import { ForgotPasswordDto } from './dto/reset-password.dto';
import { ChangePasswordDto } from './dto/change-password.dto';
import * as authUserType from './type/auth-user.type';
import { LogoutDto } from './dto/logout.dto';
import { LoginDto } from './dto/login.dto';
import { SendVerifyEmailDto, VerifyEmailDto } from './dto/verify-email.dto';
import { ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import {
  AuthTokensResponseDto,
  MessageResponseDto,
  SessionTokensResponseDto,
} from '../../common/contracts/extended-response.dto';
import { ApiStandardErrors } from '../../common/contracts/api-standard-errors.decorator';
import { GoogleLoginDto } from './dto/gg-login.dto';

@ApiTags('Auth')
@ApiStandardErrors()
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Public()
  @Post('register')
  @ApiCreatedResponse({ type: MessageResponseDto })
  async register(@Body() dto: RegisterDto) {
    await this.authService.register(dto);
    return { message: 'User registered successfully' };
  }

  @Public()
  @UseGuards(LocalAuthGuard)
  @Post('login')
  @ApiCreatedResponse({ type: AuthTokensResponseDto })
  login(
    @Body() _dto: LoginDto,
    @Request() req: { user: authUserType.AuthUser },
  ) {
    return this.authService.login(req.user);
  }

  @Public()
  @Post('google')
  @ApiOkResponse({
    type: AuthTokensResponseDto,
  })
  googleLogin(
    @Body()
    dto: GoogleLoginDto,
  ) {
    return this.authService.googleLoginWithIdToken(dto.idToken);
  }

  @Public()
  @Post('refresh')
  @ApiCreatedResponse({ type: SessionTokensResponseDto })
  async refresh(@Body() dto: RefreshTokenDto) {
    return this.authService.refresh(dto.refreshToken);
  }

  @Post('logout-one')
  @ApiCreatedResponse({ type: MessageResponseDto })
  async logout(@Body() dto: LogoutDto, @CurrentUser('id') userId: string) {
    await this.authService.logoutOne(dto, userId);
    return { message: 'Logged out successfully' };
  }

  @Post('logout-all')
  @ApiCreatedResponse({ type: MessageResponseDto })
  async logoutAll(@CurrentUser('id') userId: string) {
    await this.authService.logoutAll(userId);
    return { message: 'Logged out of all devices successfully' };
  }

  @Public()
  @Post('resend-verification-email')
  @ApiCreatedResponse({ type: MessageResponseDto })
  async sendVerificationEmail(@Body() dto: SendVerifyEmailDto) {
    await this.authService.sendVerificationEmail(dto.email);
    return { message: 'Verification email sent successfully' };
  }

  @Public()
  @Post('verify-email')
  @ApiCreatedResponse({ type: AuthTokensResponseDto })
  async verifyEmail(@Body() dto: VerifyEmailDto) {
    return this.authService.verifyEmail(dto.token, dto.email);
  }

  @Public()
  @Post('send-password-reset-code')
  @ApiCreatedResponse({ type: MessageResponseDto })
  async sendPasswordResetCode(@Body() dto: SendVerifyEmailDto) {
    await this.authService.sendPasswordResetCode(dto.email);
    return { message: 'Password reset code sent successfully' };
  }

  @Public()
  @Post('reset-password')
  @ApiCreatedResponse({ type: MessageResponseDto })
  async resetPassword(@Body() dto: ForgotPasswordDto) {
    await this.authService.resetPassword(dto);
    return { message: 'Password reset successfully' };
  }

  @Post('change-password')
  @ApiCreatedResponse({ type: MessageResponseDto })
  async changePassword(
    @Body() dto: ChangePasswordDto,
    @CurrentUser('id') userId: string,
  ) {
    await this.authService.changePassword(dto, userId);
    return { message: 'Password changed successfully' };
  }
}
