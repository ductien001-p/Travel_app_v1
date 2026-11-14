import { RouteService } from './route.service';

describe('RouteService', () => {
  const origin = { latitude: 16.0544, longitude: 108.2022 };
  const destination = { latitude: 15.8801, longitude: 108.338 };
  const route = {
    distanceMeters: 28700,
    durationSeconds: 2460,
    polyline: 'encoded',
  };

  function setup(cached: string | null = null) {
    const provider = { getRoute: jest.fn().mockResolvedValue(route) };
    const redis = {
      get: jest.fn().mockResolvedValue(cached),
      set: jest.fn().mockResolvedValue(undefined),
      incrementWithTtl: jest.fn().mockResolvedValue(1),
    };
    const config = {
      get: jest.fn((key: string) =>
        key === 'ROUTE_PREVIEW_QUOTA_PER_MINUTE' ? 2 : 600,
      ),
    };
    return {
      service: new RouteService(provider, redis as never, config as never),
      provider,
      redis,
    };
  }

  it('returns a cached route without calling Google', async () => {
    const { service, provider } = setup(JSON.stringify(route));
    await expect(service.getRoute(origin, destination)).resolves.toEqual({
      available: true,
      ...route,
    });
    expect(provider.getRoute).not.toHaveBeenCalled();
  });

  it('calls Google and caches a cache miss', async () => {
    const { service, provider, redis } = setup();
    await expect(service.getRoute(origin, destination)).resolves.toEqual({
      available: true,
      ...route,
    });
    expect(provider.getRoute).toHaveBeenCalledWith(origin, destination);
    expect(redis.set).toHaveBeenCalledWith(
      'route:google:16.0544:108.2022:15.8801:108.338',
      JSON.stringify(route),
      600,
    );
  });

  it('rounds coordinates so near-identical points share a cache entry', async () => {
    const { service, provider, redis } = setup();
    await service.getRoute(
      { latitude: 16.054400001, longitude: 108.202199999 },
      destination,
    );
    expect(provider.getRoute).toHaveBeenCalledWith(origin, destination);
    expect(redis.get).toHaveBeenCalledWith(
      'route:google:16.0544:108.2022:15.8801:108.338',
    );
  });

  it('marks provider failures unavailable without inventing route data', async () => {
    const { service, provider } = setup();
    provider.getRoute.mockRejectedValueOnce(new Error('Google unavailable'));
    await expect(service.getRoute(origin, destination)).resolves.toEqual({
      available: false,
      distanceMeters: null,
      durationSeconds: null,
      polyline: null,
      unavailableReason: 'PROVIDER_UNAVAILABLE',
    });
  });

  it('marks invalid coordinates unavailable', async () => {
    const { service, provider } = setup();
    await expect(
      service.getRoute({ latitude: Number.NaN, longitude: 0 }, destination),
    ).resolves.toMatchObject({
      available: false,
      unavailableReason: 'MISSING_COORDINATES',
    });
    expect(provider.getRoute).not.toHaveBeenCalled();
  });

  describe('previewRoute', () => {
    it('counts previews per user in a one-minute window', async () => {
      const { service, redis } = setup();
      await expect(
        service.previewRoute('user-1', origin, destination),
      ).resolves.toMatchObject({ available: true });
      expect(redis.incrementWithTtl).toHaveBeenCalledWith(
        'route:preview-quota:user-1',
        60,
      );
    });

    it('returns 429 without calling Google once the quota is used up', async () => {
      const { service, provider, redis } = setup();
      redis.incrementWithTtl.mockResolvedValueOnce(3);
      await expect(
        service.previewRoute('user-1', origin, destination),
      ).rejects.toMatchObject({
        status: 429,
        response: expect.objectContaining({ code: 'RATE_LIMITED' }),
      });
      expect(provider.getRoute).not.toHaveBeenCalled();
    });

    it('still serves the preview when the quota store is down', async () => {
      const { service, redis } = setup();
      redis.incrementWithTtl.mockRejectedValueOnce(new Error('redis down'));
      await expect(
        service.previewRoute('user-1', origin, destination),
      ).resolves.toMatchObject({ available: true });
    });
  });

  describe('getRoutes', () => {
    it('keeps segment order and caps concurrent provider calls at 4', async () => {
      const { service, provider } = setup();
      let inFlight = 0;
      let peak = 0;
      provider.getRoute.mockImplementation(async (from: typeof origin) => {
        inFlight += 1;
        peak = Math.max(peak, inFlight);
        await new Promise((resolve) => setImmediate(resolve));
        inFlight -= 1;
        return { ...route, distanceMeters: from.latitude };
      });
      const segments = Array.from({ length: 9 }, (_, index) => ({
        origin: { latitude: index, longitude: 0 },
        destination,
      }));

      const results = await service.getRoutes(segments);

      expect(peak).toBe(4);
      expect(results.map((result) => result.distanceMeters)).toEqual([
        0, 1, 2, 3, 4, 5, 6, 7, 8,
      ]);
    });
  });
});
