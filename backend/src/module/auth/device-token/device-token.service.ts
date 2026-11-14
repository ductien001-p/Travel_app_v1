import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../prisma.service';
import { RegisterDeviceTokenDto } from './dto/register-deviceToken.dto';

@Injectable()
export class DeviceTokenService {
  constructor(private readonly prisma: PrismaService) {}

  async register(userId: string, dto: RegisterDeviceTokenDto) {
    /*
     * Nếu token này trước đây thuộc tài khoản khác
     * trên cùng máy, remove association cũ.
     */
    await this.prisma.deviceToken.deleteMany({
      where: {
        token: dto.token,
        userId: {
          not: userId,
        },
      },
    });

    return this.prisma.deviceToken.upsert({
      where: {
        userId_installationId: {
          userId,
          installationId: dto.installationId,
        },
      },

      update: {
        token: dto.token,
        platform: dto.platform,
      },

      create: {
        userId,
        installationId: dto.installationId,
        token: dto.token,
        platform: dto.platform,
      },
    });
  }

  async unregister(userId: string, installationId: string) {
    await this.prisma.deviceToken.deleteMany({
      where: {
        userId,
        installationId,
      },
    });

    return {
      success: true,
    };
  }

  async getTokensByUserId(userId: string): Promise<string[]> {
    const tokens = await this.prisma.deviceToken.findMany({
      where: {
        userId,
      },
      select: {
        token: true,
      },
    });
    return tokens.map((t) => t.token);
  }

  async removeInvalidTokens(tokens: string[]): Promise<void> {
    await this.prisma.deviceToken.deleteMany({
      where: {
        token: {
          in: tokens,
        },
      },
    });
  }
}
