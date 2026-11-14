import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma.service';

@Injectable()
export class UserTravelStreakService {
  constructor(private readonly prisma: PrismaService) {}

  async bump(userId: string): Promise<{ currentDays: number }> {
    const today = new Date();
    today.setUTCHours(0, 0, 0, 0);

    const existing = await this.prisma.userTravelStreak.findUnique({
      where: { userId },
    });

    if (!existing) {
      const created = await this.prisma.userTravelStreak.create({
        data: {
          userId,
          currentDays: 1,
          lastActiveDate: today,
        },
      });
      return { currentDays: created.currentDays };
    }

    const last = new Date(existing.lastActiveDate);
    last.setUTCHours(0, 0, 0, 0);
    const diffDays = Math.round(
      (today.getTime() - last.getTime()) / 86_400_000,
    );

    if (diffDays === 0) {
      return { currentDays: existing.currentDays };
    }

    const nextDays = diffDays === 1 ? existing.currentDays + 1 : 1;
    const updated = await this.prisma.userTravelStreak.update({
      where: { userId },
      data: {
        currentDays: nextDays,
        lastActiveDate: today,
      },
    });
    return { currentDays: updated.currentDays };
  }

  async getCurrentDays(userId: string): Promise<number> {
    const streak = await this.prisma.userTravelStreak.findUnique({
      where: { userId },
      select: { currentDays: true },
    });
    return streak?.currentDays ?? 0;
  }
}
