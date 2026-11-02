import { Injectable, UnauthorizedException } from '@nestjs/common';

import { JwtService } from '@nestjs/jwt';
import { Socket } from 'socket.io';
import { JwtStrategy } from '../module/auth/strategies/jwt.strategy';

@Injectable()
export class WsJwtMiddleware {
  constructor(
    private readonly jwtService: JwtService,
    private readonly jwtStrategy: JwtStrategy,
  ) {}

  async use(socket: Socket, next: (err?: Error) => void) {
    try {
      // 1. Lấy token
      const token =
        socket.handshake.auth?.token ||
        socket.handshake.headers.authorization?.replace('Bearer ', '');

      if (!token) {
        throw new UnauthorizedException('Missing access token');
      }

      // 2. Verify JWT
      const payload = await this.jwtService.verifyAsync(token, {
        secret: process.env.JWT_SECRET,
      });

      // 3. Dùng lại validate() của JwtStrategy
      const user = await this.jwtStrategy.validate(payload);

      if (!user) {
        throw new UnauthorizedException('User not found');
      }

      // 4. Lưu user vào socket
      socket.data.user = user;
      socket.data.userId = user.id;

      // 5. Cho phép connection tiếp tục
      next();
    } catch (error) {
      console.error('[WS AUTH ERROR]', error);

      next(new Error('Unauthorized'));
    }
  }
}
