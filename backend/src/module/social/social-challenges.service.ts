import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../../prisma.service';

@Injectable()
export class SocialChallengesService {
  constructor(private readonly prisma: PrismaService) {}

  async getActive(userId: string) {
    const challenge = await this.prisma.socialChallenge.findFirst({
      where: {
        isActive: true,
        endsAt: { gt: new Date() },
      },
      orderBy: { endsAt: 'asc' },
    });
    if (!challenge) return null;

    const progress = await this.prisma.socialChallengeProgress.findUnique({
      where: {
        challengeId_userId: {
          challengeId: challenge.id,
          userId,
        },
      },
    });

    return this.mapChallenge(challenge, progress?.progressCount ?? 0);
  }

  async join(userId: string, challengeId: string) {
    const challenge = await this.prisma.socialChallenge.findFirst({
      where: {
        id: challengeId,
        isActive: true,
        endsAt: { gt: new Date() },
      },
    });
    if (!challenge) {
      throw new NotFoundException('Challenge not found or inactive');
    }

    const progress = await this.prisma.socialChallengeProgress.upsert({
      where: {
        challengeId_userId: { challengeId, userId },
      },
      create: {
        challengeId,
        userId,
        progressCount: 0,
      },
      update: {},
    });

    return this.mapChallenge(challenge, progress.progressCount);
  }

  async incrementProgress(userId: string, challengeId: string) {
    const challenge = await this.prisma.socialChallenge.findFirst({
      where: {
        id: challengeId,
        isActive: true,
        endsAt: { gt: new Date() },
      },
    });
    if (!challenge) {
      throw new NotFoundException('Challenge not found or inactive');
    }

    const existing = await this.prisma.socialChallengeProgress.findUnique({
      where: {
        challengeId_userId: { challengeId, userId },
      },
    });
    if (!existing) {
      throw new BadRequestException('Join the challenge before updating progress');
    }

    const next = Math.min(challenge.targetCount, existing.progressCount + 1);
    const progress = await this.prisma.socialChallengeProgress.update({
      where: {
        challengeId_userId: { challengeId, userId },
      },
      data: { progressCount: next },
    });

    return this.mapChallenge(challenge, progress.progressCount);
  }

  private mapChallenge(
    challenge: {
      id: string;
      eyebrow: string;
      title: string;
      rewardLabel: string;
      badgeLabel: string;
      targetCount: number;
      endsAt: Date;
    },
    progressCount: number,
  ) {
    const daysLeft = Math.max(
      0,
      Math.ceil((challenge.endsAt.getTime() - Date.now()) / 86_400_000),
    );
    const ratio =
      challenge.targetCount > 0
        ? Math.min(1, progressCount / challenge.targetCount)
        : 0;

    return {
      id: challenge.id,
      eyebrow: challenge.eyebrow,
      title: challenge.title,
      rewardLabel: challenge.rewardLabel,
      progressLabel: `${progressCount}/${challenge.targetCount} quán đã check-in`,
      progressRatio: Number(ratio.toFixed(2)),
      daysLeftLabel: daysLeft === 0 ? 'Hết hạn hôm nay' : `Còn ${daysLeft} ngày`,
      badgeLabel: challenge.badgeLabel,
      ctaLabel: progressCount > 0 ? 'Tiếp tục' : 'Tham gia ngay',
    };
  }
}
