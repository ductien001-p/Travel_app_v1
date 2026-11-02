import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
} from '@nestjs/common';
import { MediaService } from './media.service';

describe('MediaService.completeUploadMultiple', () => {
  const dto = {
    files: [
      {
        objectKey: 'avatars/user-1/0123456789abcdef.jpg',
        mimeType: 'image/jpeg',
      },
    ],
  };

  function setup(existing: unknown = null, objectExists: unknown = {}) {
    const prisma = {
      uploadedMedia: {
        findUnique: jest.fn().mockResolvedValue(existing),
        create: jest
          .fn()
          .mockResolvedValue({ id: 'media-1', userId: 'user-1' }),
      },
    };
    const s3 = { objectExists: jest.fn().mockResolvedValue(objectExists) };
    return {
      service: new MediaService(prisma as never, s3 as never),
      prisma,
      s3,
    };
  }

  it('completes an owned backend-issued object key', async () => {
    const { service, prisma } = setup();
    await expect(
      service.completeUploadMultiple('user-1', dto),
    ).resolves.toEqual([expect.objectContaining({ id: 'media-1' })]);
    expect(prisma.uploadedMedia.create).toHaveBeenCalledTimes(1);
  });

  it('is idempotent for the same active owner', async () => {
    const record = { id: 'media-1', userId: 'user-1', deletedAt: null };
    const { service, prisma } = setup(record);
    await expect(
      service.completeUploadMultiple('user-1', dto),
    ).resolves.toEqual([record]);
    expect(prisma.uploadedMedia.create).not.toHaveBeenCalled();
  });

  it('rejects another owner, a missing object, and deleted media', async () => {
    await expect(
      setup({
        userId: 'user-2',
        deletedAt: null,
      }).service.completeUploadMultiple('user-1', dto),
    ).rejects.toBeInstanceOf(ForbiddenException);
    await expect(
      setup(null, null).service.completeUploadMultiple('user-1', dto),
    ).rejects.toBeInstanceOf(BadRequestException);
    await expect(
      setup({
        userId: 'user-1',
        deletedAt: new Date(),
      }).service.completeUploadMultiple('user-1', dto),
    ).rejects.toBeInstanceOf(ConflictException);
  });

  it('rejects substring ownership and unknown folders before storage access', async () => {
    const { service, s3 } = setup();
    await expect(
      service.completeUploadMultiple('user-1', {
        files: [
          {
            objectKey: 'unknown/attacker/user-1/0123456789abcdef.jpg',
            mimeType: 'image/jpeg',
          },
        ],
      }),
    ).rejects.toBeInstanceOf(ForbiddenException);
    expect(s3.objectExists).not.toHaveBeenCalled();
  });
});
