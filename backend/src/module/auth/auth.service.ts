import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  HttpException,
  HttpStatus,
  Injectable,
  InternalServerErrorException,
  Logger,
  UnauthorizedException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import * as crypto from 'crypto';
import { JwtPayload } from './type/jwt-payload.type';
import { RegisterDto } from './dto/register.dto';
import {
  AUTH_PROVIDER,
  USER_STATUS,
} from '../../../src/generated/prisma/enums';
import { PrismaService } from '../../prisma.service';
import { RedisService } from '../../redis/redis.service';
import { MailService } from '../../mail/mail.service';
import { randomInt } from 'crypto';
import { ForgotPasswordDto } from './dto/reset-password.dto';
import { ChangePasswordDto } from './dto/change-password.dto';
import { AuthUser } from './type/auth-user.type';
import { MediaService } from '../media/media.service';
import { UploadFolder } from '../../uploads/s3/upload-folder.type';
import { LogoutDto } from './dto/logout.dto';
import { GoogleTokenVerifierService } from './google-token-verifier.service';

export interface AuthTokens {
  accessToken: string;
  refreshToken: string;
}

export interface AuthResult extends AuthTokens {
  id: string;
}

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
    private readonly redisService: RedisService,
    private readonly mailService: MailService,
    private readonly uploadedMedia: MediaService,
    private readonly googleTokenVerifier: GoogleTokenVerifierService,
  ) {}
  //Helper
  async hashPassword(plain: string): Promise<string> {
    return bcrypt.hash(
      plain,
      Number(this.configService.get<number>('SALT_ROUNDS')),
    );
  }

  async validateJwtPayload(payload: JwtPayload): Promise<AuthUser | null> {
    if (payload.type !== 'access') {
      throw new UnauthorizedException('Invalid token type');
    }
    const user = await this.prisma.user.findUnique({
      where: { id: payload.sub },
    });

    if (!user) {
      throw new UnauthorizedException('User not found');
    }
    if (user.status !== USER_STATUS.ACTIVE) {
      throw new UnauthorizedException('User is not active');
    }

    if (user.deletedAt) {
      throw new UnauthorizedException('User is deleted');
    }
    await this.assertAccessSession(payload, user.passwordChangeAt);
    const authUser: AuthUser = {
      id: user.id,
      email: user.email,
      role: user.role,
    };
    return authUser;
  }

  /**
   * Access tokens are only valid while the refresh session that issued them
   * is still live. Logout revokes that row; password change revokes every
   * row and also rejects tokens issued before passwordChangeAt.
   */
  private async assertAccessSession(
    payload: JwtPayload,
    passwordChangeAt: Date | null,
  ): Promise<void> {
    if (!payload.sid) {
      throw new UnauthorizedException('Session is no longer valid');
    }
    const session = await this.prisma.refreshToken.findUnique({
      where: { id: payload.sid },
      select: { userId: true, revoked: true, expiresAt: true },
    });
    if (
      !session ||
      session.userId !== payload.sub ||
      session.revoked ||
      session.expiresAt <= new Date()
    ) {
      throw new UnauthorizedException('Session is no longer valid');
    }
    if (passwordChangeAt && payload.iat != null) {
      const changedAtSec = Math.floor(passwordChangeAt.getTime() / 1000);
      if (payload.iat < changedAtSec) {
        throw new UnauthorizedException('Session is no longer valid');
      }
    }
  }

  async validateUser(email: string, pass: string): Promise<AuthUser | null> {
    const user = await this.prisma.user.findUnique({
      where: { email: email.toLowerCase() },
    });
    if (!user) {
      return null;
    }
    if (user.provider !== AUTH_PROVIDER.LOCAL) {
      return null;
    }
    if (user.status !== USER_STATUS.ACTIVE) {
      return null;
    }
    if (user.deletedAt) {
      return null;
    }
    if (!user?.password) {
      return null;
    }

    const isValid = await bcrypt.compare(pass, user.password);
    if (!isValid) {
      return null;
    }
    const authUser: AuthUser = {
      id: user.id,
      email: user.email,
      role: user.role,
    };
    return authUser;
  }

  async register(registerDto: RegisterDto): Promise<{ message: string }> {
    const existing = await this.prisma.user.findUnique({
      where: { email: registerDto.email.toLowerCase() },
    });
    if (existing) {
      throw new ConflictException('Email already registered');
    }
    const hashedPassword = await this.hashPassword(registerDto.password);
    const user = await this.prisma.user.create({
      data: {
        email: registerDto.email.toLowerCase(),
        password: hashedPassword,
        username: registerDto.username,
        displayname: registerDto.username,
      },
    });
    await this.sendVerificationEmail(user.email);

    return {
      message: 'Registration successful. Please verify your email.',
    };
  }

  login(user: AuthUser): Promise<AuthResult> {
    return this.issueTokens(user);
  }

  async googleLoginWithIdToken(idToken: string) {
    /*
     * ==================================================
     * 1. VERIFY GOOGLE TOKEN
     * ==================================================
     */

    const google = await this.googleTokenVerifier.verify(idToken);

    /*
     * ==================================================
     * 2. TÌM BẰNG googleId
     * ==================================================
     */

    const existingGoogleUser = await this.prisma.user.findUnique({
      where: {
        googleId: google.googleId,
      },

      select: {
        id: true,
        email: true,
        role: true,
        provider: true,
        status: true,
        deletedAt: true,
        googleId: true,
        avatarId: true,
      },
    });

    if (existingGoogleUser) {
      this.ensureGoogleUserCanLogin(existingGoogleUser);
      await this.importGoogleAvatarIfNeeded(
        existingGoogleUser.id,
        existingGoogleUser.avatarId,
        google.picture,
      );
      return this.issueTokens({
        id: existingGoogleUser.id,
        email: existingGoogleUser.email,
        role: existingGoogleUser.role,
      });
    }

    /*
     * ==================================================
     * 3. googleId chưa tồn tại
     *
     * Kiểm tra email.
     * ==================================================
     */

    const userByEmail = await this.prisma.user.findUnique({
      where: {
        email: google.email,
      },

      select: {
        id: true,
        email: true,
        role: true,
        provider: true,
        status: true,
        deletedAt: true,
        googleId: true,
      },
    });

    if (userByEmail) {
      /*
       * LOCAL email trùng Google.
       *
       * KHÔNG tự link.
       */
      if (userByEmail.provider === AUTH_PROVIDER.LOCAL) {
        throw new ConflictException(
          'This email is already registered with password login',
        );
      }

      if (userByEmail.provider !== AUTH_PROVIDER.GOOGLE) {
        throw new ConflictException(
          'This email is already registered with another authentication provider',
        );
      }

      this.ensureGoogleUserCanLogin(userByEmail);

      /*
       * GOOGLE user có googleId rồi
       * nhưng không giống Google sub hiện tại.
       */
      if (userByEmail.googleId && userByEmail.googleId !== google.googleId) {
        throw new UnauthorizedException(
          'Google account does not match this user',
        );
      }

      /*
       * Trường hợp dữ liệu Google account cũ
       * chưa có googleId.
       */
      const linkedUser = await this.prisma.user.update({
        where: {
          id: userByEmail.id,
        },

        data: {
          googleId: google.googleId,
        },

        select: {
          id: true,
          email: true,
          role: true,
          avatarId: true,
        },
      });
      await this.importGoogleAvatarIfNeeded(
        linkedUser.id,
        linkedUser.avatarId,
        google.picture,
      );
      return this.issueTokens(linkedUser);
    }

    /*
     * ==================================================
     * 4. USER MỚI
     * ==================================================
     */

    const newUser = await this.prisma.user.create({
      data: {
        email: google.email,
        username: google.name || google.email.split('@')[0],
        googleId: google.googleId,
        displayname: google.name || google.email.split('@')[0],
        provider: AUTH_PROVIDER.GOOGLE,

        status: USER_STATUS.ACTIVE,

        /*
         * Không lưu Google avatar trực tiếp
         * nếu User.avatar của project được quản lý
         * qua UploadedMedia/avatarId.
         */
      },

      select: {
        id: true,
        email: true,
        role: true,
        avatarId: true,
      },
    });
    await this.importGoogleAvatarIfNeeded(
      newUser.id,
      newUser.avatarId,
      google.picture,
    );
    return this.issueTokens(newUser);
  }
  private async importGoogleAvatarIfNeeded(
    userId: string,
    avatarId: string | null,
    picture?: string,
  ): Promise<void> {
    /*
     * User đã có avatar.
     *
     * Không overwrite.
     */
    if (avatarId) {
      return;
    }

    if (!picture) {
      return;
    }

    try {
      const media = await this.uploadedMedia.createFromExternalImage(
        userId,
        picture,
        UploadFolder.AVATARS,
      );

      /*
       * Update có điều kiện để tránh
       * overwrite nếu avatar vừa được set
       * bởi một request khác.
       */
      await this.prisma.user.updateMany({
        where: {
          id: userId,
          avatarId: null,
        },

        data: {
          avatarId: media.id,
        },
      });
    } catch (error) {
      /*
       * Avatar thất bại KHÔNG được làm
       * Google login thất bại.
       */
      this.logger.error(
        `Failed to import Google avatar for user ${userId}`,
        error,
      );
    }
  }

  private ensureGoogleUserCanLogin(user: {
    provider: AUTH_PROVIDER;
    status: USER_STATUS;
    deletedAt: Date | null;
  }): void {
    if (user.deletedAt) {
      throw new ForbiddenException('Account is unavailable');
    }

    if (user.status !== USER_STATUS.ACTIVE) {
      throw new ForbiddenException('Account is not active');
    }

    if (user.provider !== AUTH_PROVIDER.GOOGLE) {
      throw new ConflictException('Account is not a Google account');
    }
  }

  async refresh(refreshtoken: string): Promise<AuthTokens> {
    let payload: JwtPayload;

    try {
      payload = this.jwtService.verify<JwtPayload>(refreshtoken, {
        secret: this.configService.get<string>('JWT_SECRET_REFRESH'),
      });
    } catch {
      throw new UnauthorizedException('Invalid or expired refresh token');
    }

    if (payload.type !== 'refresh') {
      throw new UnauthorizedException('Invalid token type');
    }

    // Hash token cũ để tìm trong DB
    const oldHashedToken = this.hashRefreshToken(refreshtoken);

    const stored = await this.prisma.refreshToken.findFirst({
      where: {
        hashed: oldHashedToken,
        userId: payload.sub,
      },
      include: {
        user: {
          select: {
            id: true,
            email: true,
            username: true,
            avatarId: true,
            role: true,
            status: true,
            provider: true,
            deletedAt: true,
          },
        },
      },
    });

    if (!stored || stored.revoked || new Date() > stored.expiresAt) {
      throw new UnauthorizedException('Invalid or expired refresh token');
    }

    if (stored.user.status !== USER_STATUS.ACTIVE || stored.user.deletedAt) {
      throw new UnauthorizedException('User is not active');
    }

    const tokens = this.signSessionTokens(stored.user);

    await this.prisma.$transaction(async (tx) => {
      await tx.refreshToken.delete({
        where: {
          id: stored.id,
        },
      });

      await tx.refreshToken.create({
        data: {
          id: tokens.sessionId,
          userId: stored.user.id,
          hashed: this.hashRefreshToken(tokens.refreshToken),
          expiresAt: tokens.expiresAt,
        },
      });
    });

    return {
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    };
  }

  async logoutOne(
    dto: LogoutDto,
    userId: string,
  ): Promise<{ success: boolean }> {
    const { refreshToken, installationId } = dto;
    const hashed = this.hashRefreshToken(refreshToken);
    await this.prisma.$transaction([
      this.prisma.refreshToken.updateMany({
        where: { hashed, userId, revoked: false },
        data: { revoked: true },
      }),
      this.prisma.deviceToken.deleteMany({
        where: { installationId, userId },
      }),
    ]);
    return { success: true };
  }

  async logoutAll(userId: string): Promise<{ success: boolean }> {
    await this.prisma.$transaction([
      this.prisma.refreshToken.updateMany({
        where: { userId, revoked: false },
        data: { revoked: true },
      }),
      this.prisma.deviceToken.deleteMany({
        where: { userId },
      }),
    ]);
    return { success: true };
  }

  private async issueTokens(user: AuthUser): Promise<AuthResult> {
    const tokens = this.signSessionTokens(user);
    await this.prisma.refreshToken.create({
      data: {
        id: tokens.sessionId,
        hashed: this.hashRefreshToken(tokens.refreshToken),
        userId: user.id,
        expiresAt: tokens.expiresAt,
      },
    });
    return {
      id: user.id,
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    };
  }

  private signSessionTokens(user: AuthUser): AuthTokens & {
    sessionId: string;
    expiresAt: Date;
  } {
    const sessionId = crypto.randomUUID();
    const accessPayload: JwtPayload = {
      sub: user.id,
      email: user.email,
      role: user.role,
      type: 'access',
      sid: sessionId,
    };
    const refreshPayload: JwtPayload = {
      sub: user.id,
      email: user.email,
      role: user.role,
      type: 'refresh',
      sid: sessionId,
      jti: crypto.randomUUID(),
    };
    const accessToken = this.jwtService.sign(accessPayload, {
      expiresIn: this.configService.get('ACCESS_TOKEN_EXPIRY')!,
    });
    const refreshToken = this.jwtService.sign(refreshPayload, {
      secret: this.configService.get('JWT_SECRET_REFRESH')!,
      expiresIn: this.configService.get('REFRESH_TOKEN_EXPIRY')!,
    });
    const decoded = this.jwtService.decode(refreshToken);

    if (!decoded || typeof decoded === 'string' || !decoded.exp) {
      throw new InternalServerErrorException(
        'Failed to determine refresh token expiration',
      );
    }

    return {
      accessToken,
      refreshToken,
      sessionId,
      expiresAt: new Date(decoded.exp * 1000),
    };
  }

  async sendVerificationEmail(email: string): Promise<void> {
    const user = await this.prisma.user.findUnique({
      where: { email: email.toLowerCase() },
    });

    if (!user) {
      throw new BadRequestException('User not found');
    }

    if (user.status === USER_STATUS.ACTIVE) {
      throw new BadRequestException('User is already active');
    }
    if (user.provider !== AUTH_PROVIDER.LOCAL) {
      throw new BadRequestException(
        'Verification email is only for local accounts',
      );
    }

    const rateLimitKey = `email_verification_rate_limit:${user.id}`;
    const existingRateLimit = await this.redisService.get(rateLimitKey);

    if (existingRateLimit) {
      throw new HttpException(
        'You can only request a verification email once every 1 minute',
        HttpStatus.TOO_MANY_REQUESTS,
      );
    }
    const verificationToken = randomInt(100000, 1000000).toString();

    const redisKey = `email_verification:${email.toLowerCase()}`;

    await this.redisService.set(redisKey, verificationToken, 5 * 60);

    await this.mailService.sendVerificationCode(
      email.toLowerCase(),
      verificationToken,
    );
    await this.redisService.set(rateLimitKey, '1', 1 * 60);
  }

  async verifyEmail(token: string, email: string): Promise<AuthTokens> {
    const redisKey = `email_verification:${email.toLowerCase()}`;

    const verificationToken = await this.redisService.get(redisKey);

    if (verificationToken !== token) {
      throw new BadRequestException('Invalid or expired verification token');
    }
    const user = await this.prisma.user.findFirst({
      where: {
        email: email.toLowerCase(),
        provider: AUTH_PROVIDER.LOCAL,
        status: USER_STATUS.INACTIVE,
        deletedAt: null,
      },
      select: {
        id: true,
        email: true,
        role: true,
      },
    });
    if (!user) {
      await this.redisService.delete(redisKey);
      throw new BadRequestException('User not found');
    }
    const updatedUser = await this.prisma.user.update({
      where: { id: user.id },
      data: { status: USER_STATUS.ACTIVE },
      select: {
        id: true,
        email: true,
        role: true,
      },
    });
    await this.redisService.delete(redisKey);
    return this.issueTokens(updatedUser);
  }

  async sendPasswordResetCode(email: string): Promise<void> {
    const user = await this.prisma.user.findUnique({
      where: { email: email.toLowerCase() },
    });

    if (!user) {
      return;
    }
    if (user.provider !== AUTH_PROVIDER.LOCAL) {
      // Keep the public response indistinguishable from an unknown account.
      return;
    }
    const rateLimitKey = `password_verification_rate_limit:${user.id}`;
    const existingRateLimit = await this.redisService.get(rateLimitKey);

    if (existingRateLimit) {
      throw new HttpException(
        'You can only request a verification email once every 1 minute',
        HttpStatus.TOO_MANY_REQUESTS,
      );
    }
    const verificationToken = randomInt(100000, 1000000).toString();

    const redisKey = `password_verification:${email.toLowerCase()}`;

    await this.redisService.set(redisKey, verificationToken, 5 * 60);

    await this.mailService.sendVerificationCode(
      email.toLowerCase(),
      verificationToken,
    );
    await this.redisService.set(rateLimitKey, '1', 60);
  }

  async resetPassword(forgotPassword: ForgotPasswordDto): Promise<void> {
    const email = forgotPassword.email.toLowerCase();

    const redisKey = `password_verification:${email}`;

    const verificationToken = await this.redisService.get(redisKey);

    if (verificationToken !== forgotPassword.token) {
      throw new BadRequestException('Invalid or expired verification token');
    }

    const user = await this.prisma.user.findUnique({
      where: { email },
      select: {
        id: true,
        provider: true,
        password: true,
      },
    });

    if (!user) {
      await this.redisService.delete(redisKey);

      throw new BadRequestException('User not found');
    }

    if (user.provider !== AUTH_PROVIDER.LOCAL) {
      throw new BadRequestException(
        'Password reset is only allowed for local accounts',
      );
    }
    if (
      forgotPassword.password.length < 8 &&
      forgotPassword.password.length > 64
    ) {
      throw new BadRequestException(
        'Password must be between 8 and 64 characters',
      );
    }

    const hashedPassword = await this.hashPassword(forgotPassword.password);

    if (hashedPassword === user.password) {
      throw new BadRequestException(
        'New password must be different from the old password',
      );
    }
    await this.prisma.$transaction(async (tx) => {
      await tx.user.update({
        where: {
          id: user.id,
        },
        data: {
          password: hashedPassword,
          passwordChangeAt: new Date(),
        },
      });

      await tx.refreshToken.updateMany({
        where: {
          userId: user.id,
          revoked: false,
        },
        data: {
          revoked: true,
        },
      });
    });

    await this.redisService.delete(redisKey);
  }

  async changePassword(dto: ChangePasswordDto, userId: string): Promise<void> {
    const user = await this.prisma.user.findUnique({ where: { id: userId } });
    if (!user) {
      throw new BadRequestException('User not found');
    }
    if (user.provider !== AUTH_PROVIDER.LOCAL) {
      throw new BadRequestException(
        'Password change is only allowed for local accounts',
      );
    }
    const isMatch = await bcrypt.compare(dto.oldPassword, user.password!);

    if (!isMatch) {
      throw new BadRequestException('Current password is incorrect');
    }

    const hashedPassword = await this.hashPassword(dto.newPassword);
    await this.prisma.$transaction(async (tx) => {
      await tx.user.update({
        where: {
          id: user.id,
        },
        data: {
          password: hashedPassword,
          passwordChangeAt: new Date(),
        },
      });

      await tx.refreshToken.updateMany({
        where: {
          userId: user.id,
          revoked: false,
        },
        data: {
          revoked: true,
        },
      });
    });
  }

  private hashRefreshToken(token: string): string {
    return crypto.createHash('sha256').update(token).digest('hex');
  }
}
