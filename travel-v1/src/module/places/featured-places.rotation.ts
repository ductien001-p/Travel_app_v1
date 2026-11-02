import { createHash } from 'crypto';

export const FEATURED_POOL_SIZE = 24;
export const FEATURED_COUNT = 3;
export const FEATURED_SUBTITLE = 'Nổi bật hôm nay';

/** Calendar date in the viewer's offset, as yyyy-MM-dd. */
export function viewerDateKey(now: Date, utcOffsetMinutes: number): string {
  const shifted = new Date(now.getTime() + utcOffsetMinutes * 60_000);
  const year = shifted.getUTCFullYear();
  const month = String(shifted.getUTCMonth() + 1).padStart(2, '0');
  const day = String(shifted.getUTCDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}

export function pickFeaturedIds(
  orderedIds: readonly string[],
  userId: string,
  dateKey: string,
  count = FEATURED_COUNT,
): string[] {
  const pool = orderedIds.slice(0, FEATURED_POOL_SIZE);
  return seededShuffle(pool, seedOf(userId, dateKey)).slice(0, count);
}

function seedOf(userId: string, dateKey: string): number {
  return createHash('sha256')
    .update(`${userId}|${dateKey}`)
    .digest()
    .readUInt32BE(0);
}

function seededShuffle<T>(items: readonly T[], seed: number): T[] {
  const next = [...items];
  let state = seed >>> 0;
  const random = () => {
    state = (state + 0x6d2b79f5) >>> 0;
    let t = state;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
  for (let index = next.length - 1; index > 0; index -= 1) {
    const swap = Math.floor(random() * (index + 1));
    const current = next[index];
    next[index] = next[swap];
    next[swap] = current;
  }
  return next;
}
