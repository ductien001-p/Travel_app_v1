import { NotFoundException } from '@nestjs/common';
import { SocialPostVisibility } from '../../generated/prisma/enums';
import { PublicImagesService } from './public-images.service';

const createdAt = new Date('2025-07-20T05:45:00.000Z');

function publicPost(overrides: Record<string, unknown> = {}) {
  return {
    id: 'post-1',
    caption: '  Sunrise  ',
    placeDetail: 'Ghềnh đá',
    likesCount: 4,
    commentsCount: 2,
    createdAt,
    author: { displayname: 'Lan' },
    place: {
      name: 'Bàn Cờ',
      city: 'Đà Nẵng',
      latitude: 16.12,
      longitude: 108.27,
    },
    postMedias: [
      {
        mediaId: 'media-1',
        media: { objectKey: 'posts/user/a.jpg', deletedAt: null },
      },
      {
        mediaId: 'media-2',
        media: { objectKey: 'posts/user/gone.jpg', deletedAt: createdAt },
      },
    ],
    likes: [{ id: 'like-1' }],
    ...overrides,
  };
}

function build(post: unknown) {
  const findFirst = jest.fn().mockResolvedValue(post);
  const service = new PublicImagesService(
    { post: { findFirst } } as never,
    { getPublicUrl: (key: string) => `https://cdn.test/${key}` } as never,
  );
  return { service, findFirst };
}

describe('PublicImagesService.getAlbum', () => {
  it('maps a public post into a viewer album', async () => {
    const { service, findFirst } = build(publicPost());

    const album = await service.getAlbum('social-post-post-1', 'user-1');

    expect(findFirst).toHaveBeenCalledWith(
      expect.objectContaining({
        where: {
          id: 'post-1',
          deletedAt: null,
          visibility: SocialPostVisibility.PUBLIC,
        },
      }),
    );
    expect(album.id).toBe('social-post-post-1');
    expect(album.title).toBe('Sunrise');
    expect(album.tripTitle).toBe('Bàn Cờ');
    expect(album.images).toHaveLength(1);
    expect(album.images[0]).toMatchObject({
      id: 'media-1',
      imageUrl: 'https://cdn.test/posts/user/a.jpg',
      cityLabel: 'Đà Nẵng',
      locationLabel: 'Ghềnh đá',
      latitude: 16.12,
      longitude: 108.27,
      likeCount: 4,
      commentCount: 2,
      likedByMe: true,
      canSetAsCover: false,
      canDelete: false,
    });
  });

  it('uses the author name when the caption is empty', async () => {
    const { service } = build(
      publicPost({
        caption: '   ',
        place: null,
        placeDetail: null,
        likes: [],
      }),
    );

    const album = await service.getAlbum('social-post-post-1', 'user-1');

    expect(album.title).toBe('Ảnh của Lan');
    expect(album.tripTitle).toBe('Bài viết cộng đồng');
    expect(album.images[0].likedByMe).toBe(false);
    expect(album.images[0].latitude).toBeNull();
  });

  it('rejects an album id that is not a social post', async () => {
    const { service, findFirst } = build(null);

    await expect(service.getAlbum('ban-co-sunrise', 'user-1')).rejects.toBeInstanceOf(
      NotFoundException,
    );
    expect(findFirst).not.toHaveBeenCalled();
  });

  it('returns not found when the public post is missing', async () => {
    const { service } = build(null);

    await expect(
      service.getAlbum('social-post-missing', 'user-1'),
    ).rejects.toBeInstanceOf(NotFoundException);
  });
});
