import { Injectable, NotFoundException } from '@nestjs/common';
import { SocialPostVisibility } from '../../generated/prisma/enums';
import { PrismaService } from '../../prisma.service';
import { S3Service } from '../../uploads/s3/s3.service';
import { PublicImageAlbumResponseDto } from './dto/public-image-album-response.dto';

const SOCIAL_POST_PREFIX = 'social-post-';

@Injectable()
export class PublicImagesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly s3: S3Service,
  ) {}

  async getAlbum(
    albumId: string,
    userId: string,
  ): Promise<PublicImageAlbumResponseDto> {
    const postId = this.postIdFromAlbum(albumId);
    if (!postId) {
      throw new NotFoundException('Album not found');
    }

    const post = await this.prisma.post.findFirst({
      where: {
        id: postId,
        deletedAt: null,
        visibility: SocialPostVisibility.PUBLIC,
      },
      select: {
        id: true,
        caption: true,
        placeDetail: true,
        likesCount: true,
        commentsCount: true,
        createdAt: true,
        author: { select: { displayname: true } },
        place: {
          select: {
            name: true,
            city: true,
            latitude: true,
            longitude: true,
          },
        },
        postMedias: {
          orderBy: { orderIndex: 'asc' },
          select: {
            mediaId: true,
            media: { select: { objectKey: true, deletedAt: true } },
          },
        },
        likes: {
          where: { userId },
          select: { id: true },
          take: 1,
        },
      },
    });

    if (!post) {
      throw new NotFoundException('Album not found');
    }

    const caption = post.caption.trim();
    const authorName = post.author.displayname.trim() || 'người dùng';
    const placeName = post.place?.name?.trim() || '';
    const likedByMe = post.likes.length > 0;
    const images = post.postMedias.flatMap((item) => {
      const media = item.media;
      if (!media || media.deletedAt) return [];
      const imageUrl = this.s3.getPublicUrl(media.objectKey);
      return [
        {
          id: item.mediaId,
          imageUrl,
          thumbnailUrl: imageUrl,
          caption: caption || null,
          cityLabel: post.place?.city ?? null,
          locationLabel: post.placeDetail?.trim() || placeName || null,
          locationShortLabel: placeName || null,
          latitude: post.place?.latitude ?? null,
          longitude: post.place?.longitude ?? null,
          capturedAt: post.createdAt.toISOString(),
          likeCount: post.likesCount,
          commentCount: post.commentsCount,
          likedByMe,
          canSetAsCover: false,
          canDelete: false,
        },
      ];
    });

    return {
      id: `${SOCIAL_POST_PREFIX}${post.id}`,
      title: caption || `Ảnh của ${authorName}`,
      tripTitle: placeName || 'Bài viết cộng đồng',
      images,
    };
  }

  private postIdFromAlbum(albumId: string): string | null {
    if (!albumId.startsWith(SOCIAL_POST_PREFIX)) return null;
    const postId = albumId.slice(SOCIAL_POST_PREFIX.length).trim();
    return postId.length > 0 ? postId : null;
  }
}
