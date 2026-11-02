import { SavedPlacesService } from './saved-places.service';
import { NotFoundException } from '@nestjs/common';

describe('SavedPlacesService.remove', () => {
  it('removes the saved row and every collection item for that place', async () => {
    const deleteMany = jest.fn();
    const removeSaved = jest.fn();
    const prisma = {
      savedPlace: {
        findUnique: jest.fn().mockResolvedValue({ id: 'saved-1' }),
      },
      $transaction: jest.fn(async (run: (tx: unknown) => Promise<void>) =>
        run({
          placeCollectionItem: { deleteMany },
          savedPlace: { delete: removeSaved },
        }),
      ),
    };
    const service = new SavedPlacesService(prisma as never);
    await service.remove('user-1', 'place-1');
    expect(deleteMany).toHaveBeenCalledWith({
      where: { placeId: 'place-1', collection: { ownerId: 'user-1' } },
    });
    expect(removeSaved).toHaveBeenCalled();
  });

  it('does not write when the place was never saved', async () => {
    const prisma = {
      savedPlace: { findUnique: jest.fn().mockResolvedValue(null) },
      $transaction: jest.fn(),
    };
    const service = new SavedPlacesService(prisma as never);
    await expect(service.remove('user-1', 'place-1')).rejects.toBeInstanceOf(
      NotFoundException,
    );
    expect(prisma.$transaction).not.toHaveBeenCalled();
  });
});
