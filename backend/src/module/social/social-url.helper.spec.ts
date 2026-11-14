import {
  deriveTrendLabel,
  formatRelativeTimeVi,
  toPublicMediaUrl,
} from './social-url.helper';

describe('social-url.helper', () => {
  it('resolves public media urls and skips deleted media', () => {
    const getPublicUrl = (key: string) => `https://cdn/${key}`;
    expect(
      toPublicMediaUrl(getPublicUrl, {
        objectKey: 'a.jpg',
        deletedAt: null,
      }),
    ).toBe('https://cdn/a.jpg');
    expect(
      toPublicMediaUrl(getPublicUrl, {
        objectKey: 'b.jpg',
        deletedAt: new Date(),
      }),
    ).toBeNull();
    expect(toPublicMediaUrl(getPublicUrl, null)).toBeNull();
  });

  it('formats relative vietnamese time labels', () => {
    const now = new Date('2026-11-10T12:00:00.000Z');
    expect(
      formatRelativeTimeVi(new Date('2026-11-10T11:50:00.000Z'), now),
    ).toBe('10 phút trước');
    expect(
      formatRelativeTimeVi(new Date('2026-11-10T10:00:00.000Z'), now),
    ).toBe('2 giờ trước');
  });

  it('derives trend label for hot recent posts', () => {
    expect(deriveTrendLabel(80, new Date())).toBe('Trending hôm nay');
    expect(deriveTrendLabel(10, new Date())).toBeNull();
  });
});
