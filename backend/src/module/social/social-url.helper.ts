type MediaLike = {
  objectKey: string;
  deletedAt: Date | null;
} | null;

export function toPublicMediaUrl(
  getPublicUrl: (objectKey: string) => string,
  media: MediaLike | undefined,
): string | null {
  if (!media || media.deletedAt) return null;
  return getPublicUrl(media.objectKey);
}

export function formatRelativeTimeVi(date: Date, now = new Date()): string {
  const diffMs = Math.max(0, now.getTime() - date.getTime());
  const minutes = Math.floor(diffMs / 60_000);
  if (minutes < 1) return 'Vừa xong';
  if (minutes < 60) return `${minutes} phút trước`;
  const hours = Math.floor(minutes / 60);
  if (hours < 24) return `${hours} giờ trước`;
  const days = Math.floor(hours / 24);
  if (days < 7) return `${days} ngày trước`;
  return date.toLocaleDateString('vi-VN');
}

export function deriveTrendLabel(likesCount: number, createdAt: Date): string | null {
  const ageHours = (Date.now() - createdAt.getTime()) / 3_600_000;
  if (likesCount >= 50 && ageHours <= 48) return 'Trending hôm nay';
  return null;
}
