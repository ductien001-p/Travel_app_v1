import { SocialChallengesService } from './social-challenges.service';

describe('SocialChallengesService', () => {
  const prisma = {
    socialChallenge: {
      findFirst: jest.fn(),
    },
    socialChallengeProgress: {
      findUnique: jest.fn(),
      upsert: jest.fn(),
    },
  };

  const service = new SocialChallengesService(prisma as never);

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('maps active challenge with progress', async () => {
    const endsAt = new Date();
    endsAt.setDate(endsAt.getDate() + 3);
    prisma.socialChallenge.findFirst.mockResolvedValue({
      id: 'ch1',
      eyebrow: 'THỬ THÁCH TUẦN NÀY',
      title: 'Cafe Sơn Trà',
      rewardLabel: '+150 Xu',
      badgeLabel: 'Biển Xanh',
      targetCount: 3,
      endsAt,
    });
    prisma.socialChallengeProgress.findUnique.mockResolvedValue({
      progressCount: 1,
    });

    const result = await service.getActive('user-1');
    expect(result?.id).toBe('ch1');
    expect(result?.progressLabel).toContain('1/3');
    expect(result?.progressRatio).toBeCloseTo(0.33, 1);
    expect(result?.ctaLabel).toBe('Tiếp tục');
  });

  it('returns null when no active challenge', async () => {
    prisma.socialChallenge.findFirst.mockResolvedValue(null);
    await expect(service.getActive('user-1')).resolves.toBeNull();
  });

  it('joins an active challenge', async () => {
    const endsAt = new Date();
    endsAt.setDate(endsAt.getDate() + 2);
    prisma.socialChallenge.findFirst.mockResolvedValue({
      id: 'ch1',
      eyebrow: 'THỬ THÁCH TUẦN NÀY',
      title: 'Cafe Sơn Trà',
      rewardLabel: '+150 Xu',
      badgeLabel: 'Biển Xanh',
      targetCount: 3,
      endsAt,
    });
    prisma.socialChallengeProgress.upsert.mockResolvedValue({
      progressCount: 0,
    });

    const result = await service.join('user-1', 'ch1');
    expect(result.ctaLabel).toBe('Tham gia ngay');
    expect(prisma.socialChallengeProgress.upsert).toHaveBeenCalled();
  });
});
