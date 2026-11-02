import { RANK } from '../../generated/prisma/enums';
import { RankingService } from './ranking.service';

describe('RankingService.awardTripCompletion', () => {
  function setup(stored: { totalPoints: number; rank: RANK }) {
    const tx = {
      userRanking: {
        upsert: jest.fn().mockResolvedValue(stored),
        update: jest.fn().mockResolvedValue({}),
      },
    };
    return { service: new RankingService({} as never), tx };
  }

  it('increments points and trip count atomically on the caller transaction', async () => {
    const { service, tx } = setup({ totalPoints: 150, rank: RANK.EXPLORER });

    await service.awardTripCompletion(tx as never, 'user-1', 50);

    expect(tx.userRanking.upsert).toHaveBeenCalledWith({
      where: { userId: 'user-1' },
      create: {
        userId: 'user-1',
        totalPoints: 50,
        tripsCompleted: 1,
        rank: RANK.BEGINNER,
      },
      update: {
        totalPoints: { increment: 50 },
        tripsCompleted: { increment: 1 },
      },
      select: { totalPoints: true, rank: true },
    });
    expect(tx.userRanking.update).not.toHaveBeenCalled();
  });

  it('promotes the rank from the post-increment total', async () => {
    const { service, tx } = setup({ totalPoints: 520, rank: RANK.EXPLORER });

    await service.awardTripCompletion(tx as never, 'user-1', 40);

    expect(tx.userRanking.update).toHaveBeenCalledWith({
      where: { userId: 'user-1' },
      data: { rank: RANK.ADVENTURER },
    });
  });

  it('propagates write failures so the completion rolls back', async () => {
    const { service, tx } = setup({ totalPoints: 0, rank: RANK.BEGINNER });
    tx.userRanking.upsert.mockRejectedValueOnce(new Error('write failed'));

    await expect(
      service.awardTripCompletion(tx as never, 'user-1', 10),
    ).rejects.toThrow('write failed');
  });
});
