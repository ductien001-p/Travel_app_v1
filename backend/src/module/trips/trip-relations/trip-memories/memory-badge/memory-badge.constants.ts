import { MEMORY_BADGE } from '../../../../../generated/prisma/enums';

/** Text shown on the photo; the API sends the label, not the enum. */
export const MEMORY_BADGE_LABELS: Record<MEMORY_BADGE, string> = {
  [MEMORY_BADGE.NIGHT]: 'Khoảnh khắc đêm',
  [MEMORY_BADGE.SCENERY]: 'Khoảnh khắc nổi bật',
  [MEMORY_BADGE.PEOPLE]: 'Khoảnh khắc đáng nhớ',
  [MEMORY_BADGE.FOOD]: 'Khoảnh khắc ẩm thực',
};

export function memoryBadgeLabel(badge: MEMORY_BADGE | null): string | null {
  return badge ? MEMORY_BADGE_LABELS[badge] : null;
}
