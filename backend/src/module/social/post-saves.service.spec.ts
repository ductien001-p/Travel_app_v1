import { BadRequestException, NotFoundException } from '@nestjs/common';
import { PostSavesService } from './post-saves.service';

describe('PostSavesService', () => {
  const prisma = {
    socialPostSave: {
      findUnique: jest.fn(),
      create: jest.fn(),
      delete: jest.fn(),
    },
    post: {
      update: jest.fn(),
    },
    $transaction: jest.fn(),
  };

  const postService = {
    ensureCanAccessPost: jest.fn(),
  };

  const service = new PostSavesService(prisma as never, postService as never);

  beforeEach(() => {
    jest.clearAllMocks();
    prisma.$transaction.mockImplementation(async (fn: (tx: typeof prisma) => Promise<void>) =>
      fn(prisma),
    );
  });

  it('saves a post and increments savesCount', async () => {
    postService.ensureCanAccessPost.mockResolvedValue(undefined);
    prisma.socialPostSave.findUnique.mockResolvedValue(null);
    prisma.socialPostSave.create.mockResolvedValue({ id: 'save-1' });
    prisma.post.update.mockResolvedValue({});

    await service.save('user-1', 'post-1');

    expect(postService.ensureCanAccessPost).toHaveBeenCalledWith('post-1', 'user-1');
    expect(prisma.socialPostSave.create).toHaveBeenCalledWith({
      data: { postId: 'post-1', userId: 'user-1' },
    });
    expect(prisma.post.update).toHaveBeenCalledWith({
      where: { id: 'post-1' },
      data: { savesCount: { increment: 1 } },
    });
  });

  it('rejects duplicate save', async () => {
    postService.ensureCanAccessPost.mockResolvedValue(undefined);
    prisma.socialPostSave.findUnique.mockResolvedValue({ id: 'save-1' });

    await expect(service.save('user-1', 'post-1')).rejects.toBeInstanceOf(
      BadRequestException,
    );
  });

  it('unsaves a post and decrements savesCount', async () => {
    prisma.socialPostSave.findUnique.mockResolvedValue({ id: 'save-1' });
    prisma.socialPostSave.delete.mockResolvedValue({});
    prisma.post.update.mockResolvedValue({});

    await service.unsave('user-1', 'post-1');

    expect(prisma.socialPostSave.delete).toHaveBeenCalled();
    expect(prisma.post.update).toHaveBeenCalledWith({
      where: { id: 'post-1' },
      data: { savesCount: { decrement: 1 } },
    });
  });

  it('throws when unsave target is missing', async () => {
    prisma.socialPostSave.findUnique.mockResolvedValue(null);
    await expect(service.unsave('user-1', 'post-1')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });
});
