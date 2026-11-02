import { pickFeaturedIds, viewerDateKey } from './featured-places.rotation';

const ids = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

describe('featured place rotation', () => {
  it('keeps the same three places for one user on one local day', () => {
    const first = pickFeaturedIds(ids, 'user-a', '2026-10-31');
    const second = pickFeaturedIds(ids, 'user-a', '2026-10-31');
    expect(first).toEqual(second);
    expect(first).toHaveLength(3);
  });

  it('changes the selection for another user or the next day', () => {
    const today = pickFeaturedIds(ids, 'user-a', '2026-10-31');
    const otherUser = pickFeaturedIds(ids, 'user-b', '2026-10-31');
    const tomorrow = pickFeaturedIds(ids, 'user-a', '2026-11-01');
    expect(otherUser).not.toEqual(today);
    expect(tomorrow).not.toEqual(today);
  });

  it('builds the viewer calendar date from the utc offset', () => {
    const utcEvening = new Date('2026-10-31T20:00:00.000Z');
    expect(viewerDateKey(utcEvening, 420)).toBe('2026-11-01');
    expect(viewerDateKey(utcEvening, 0)).toBe('2026-10-31');
  });
});
