import {
  deriveTrendLabel,
  formatRelativeTimeVi,
  toPublicMediaUrl,
} from './social-url.helper';

export const postAuthorSelect = {
  id: true,
  username: true,
  displayname: true,
  avatarId: true,
  isVerified: true,
  profileBadge: true,
  avatar: { select: { objectKey: true, deletedAt: true } },
} as const;

export const postMediaSelect = {
  mediaId: true,
  orderIndex: true,
  media: { select: { objectKey: true, deletedAt: true } },
} as const;

export const postPlaceSelect = {
  id: true,
  name: true,
} as const;

type MediaRef = { objectKey: string; deletedAt: Date | null } | null;

type AuthorRow = {
  id: string;
  username: string;
  displayname: string;
  avatarId: string | null;
  isVerified: boolean;
  profileBadge: string | null;
  avatar?: MediaRef;
};

type MediaRow = {
  mediaId: string;
  orderIndex: number;
  media?: MediaRef;
};

type PlaceRow = {
  id: string;
  name: string;
} | null;

type PreviewCommentRow = {
  id: string;
  content: string;
  createdAt: Date;
  user: {
    id: string;
    username: string;
    displayname: string;
    avatar?: MediaRef;
  };
} | null;

export function mapEnrichedPost(
  post: {
    id: string;
    authorId: string;
    placeId: string | null;
    caption: string;
    visibility: string;
    tipTitle?: string | null;
    tipBody?: string | null;
    topic?: string | null;
    placeDetail?: string | null;
    likesCount: number;
    commentsCount: number;
    sharesCount: number;
    savesCount?: number;
    createdAt: Date;
    updatedAt: Date;
    deletedAt?: Date | null;
    author: AuthorRow;
    place?: PlaceRow;
    postMedias: MediaRow[];
    _count?: { likes: number; comments: number; shares: number; saves?: number };
    likes?: { id: string }[];
    shares?: { id: string }[];
    saves?: { id: string }[];
    comments?: PreviewCommentRow[];
  },
  getPublicUrl: (objectKey: string) => string,
  opts?: { liked?: boolean; shared?: boolean; bookmarked?: boolean },
) {
  const liked =
    opts?.liked ?? (Array.isArray(post.likes) ? post.likes.length > 0 : false);
  const shared =
    opts?.shared ?? (Array.isArray(post.shares) ? post.shares.length > 0 : false);
  const bookmarked =
    opts?.bookmarked ??
    (Array.isArray(post.saves) ? post.saves.length > 0 : false);

  const preview = post.comments?.[0] ?? null;

  return {
    id: post.id,
    authorId: post.authorId,
    placeId: post.placeId,
    caption: post.caption,
    visibility: post.visibility,
    tipTitle: post.tipTitle ?? null,
    tipBody: post.tipBody ?? null,
    topic: post.topic ?? null,
    placeDetail: post.placeDetail ?? null,
    likesCount: post.likesCount,
    commentsCount: post.commentsCount,
    sharesCount: post.sharesCount,
    savesCount: post.savesCount ?? post._count?.saves ?? 0,
    createdAt: post.createdAt,
    updatedAt: post.updatedAt,
    author: {
      id: post.author.id,
      username: post.author.username,
      displayName: post.author.displayname,
      avatarId: post.author.avatarId,
      avatarUrl: toPublicMediaUrl(getPublicUrl, post.author.avatar ?? null),
      badgeLabel: post.author.profileBadge,
      verified: post.author.isVerified,
    },
    place: post.place
      ? {
          id: post.place.id,
          name: post.place.name,
          detail: post.placeDetail ?? null,
        }
      : null,
    postMedias: post.postMedias.map((item) => ({
      mediaId: item.mediaId,
      orderIndex: item.orderIndex,
      url: toPublicMediaUrl(getPublicUrl, item.media ?? null),
    })),
    _count: {
      likes: post._count?.likes ?? post.likesCount,
      comments: post._count?.comments ?? post.commentsCount,
      shares: post._count?.shares ?? post.sharesCount,
      saves: post._count?.saves ?? post.savesCount ?? 0,
    },
    liked,
    shared,
    bookmarked,
    trendLabel: deriveTrendLabel(post.likesCount, post.createdAt),
    timeLabel: formatRelativeTimeVi(post.createdAt),
    previewComment: preview
      ? {
          id: preview.id,
          authorName: preview.user.displayname || preview.user.username,
          avatarUrl: toPublicMediaUrl(getPublicUrl, preview.user.avatar ?? null),
          text: preview.content,
          timeLabel: formatRelativeTimeVi(preview.createdAt),
          replyLabel: null,
        }
      : null,
  };
}

export function viewerInteractionInclude(userId: string) {
  return {
    likes: {
      where: { userId },
      select: { id: true },
    },
    shares: {
      where: { userId },
      select: { id: true },
    },
    saves: {
      where: { userId },
      select: { id: true },
    },
    comments: {
      where: { deletedAt: null },
      orderBy: { createdAt: 'desc' as const },
      take: 1,
      select: {
        id: true,
        content: true,
        createdAt: true,
        user: {
          select: {
            id: true,
            username: true,
            displayname: true,
            avatar: { select: { objectKey: true, deletedAt: true } },
          },
        },
      },
    },
  };
}
