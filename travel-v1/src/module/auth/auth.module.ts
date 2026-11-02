import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { JwtModule } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { JwtStrategy } from './strategies/jwt.strategy';
import { UsersModule } from '../users/users.module';
import { LocalStrategy } from './strategies/local.strategy';
import { PrismaModule } from '../../prisma.module';
import { MediaModule } from '../media/media.module';
import { WsJwtMiddleware } from '../../websocket/ws-jwt-middleware';
import { GoogleTokenVerifierService } from './google-token-verifier.service';

@Module({
  imports: [
    PrismaModule,
    PassportModule,
    JwtModule.registerAsync({
      imports: [ConfigModule],
      useFactory: (config: ConfigService) => ({
        secret: config.get<string>('JWT_SECRET'),
        signOptions: {
          expiresIn: '15m', // default for access tokens; override per sign() when needed (e.g. refresh)
        },
      }),
      inject: [ConfigService],
    }),
    UsersModule,
    MediaModule,
  ],
  controllers: [AuthController],
  providers: [
    AuthService,
    JwtStrategy,
    LocalStrategy,
    WsJwtMiddleware,
    GoogleTokenVerifierService,
  ],
  exports: [AuthService, JwtStrategy, WsJwtMiddleware],
})
export class AuthModule {}
