import { GoogleRoutesProvider } from './google-routes.provider';

describe('GoogleRoutesProvider', () => {
  const coordinate = { latitude: 16, longitude: 108 };

  afterEach(() => jest.restoreAllMocks());

  it('normalizes the Google route response', async () => {
    const provider = new GoogleRoutesProvider({
      get: jest.fn().mockReturnValue('api-key'),
    } as never);
    jest.spyOn(global, 'fetch').mockResolvedValue({
      ok: true,
      json: jest.fn().mockResolvedValue({
        routes: [
          {
            distanceMeters: 1200,
            duration: '123.4s',
            polyline: { encodedPolyline: 'polyline' },
          },
        ],
      }),
    } as never);

    await expect(provider.getRoute(coordinate, coordinate)).resolves.toEqual({
      distanceMeters: 1200,
      durationSeconds: 123,
      polyline: 'polyline',
    });
  });

  it('bounds the request with a timeout and maps network failures', async () => {
    const provider = new GoogleRoutesProvider({
      get: jest.fn().mockReturnValue('api-key'),
    } as never);
    const fetchSpy = jest
      .spyOn(global, 'fetch')
      .mockRejectedValue(new DOMException('timed out', 'TimeoutError'));

    await expect(provider.getRoute(coordinate, coordinate)).rejects.toThrow(
      'Google Routes is unreachable',
    );
    expect(fetchSpy.mock.calls[0][1]?.signal).toBeInstanceOf(AbortSignal);
  });

  it('does not call Google when the key is missing', async () => {
    const provider = new GoogleRoutesProvider({
      get: jest.fn().mockReturnValue(undefined),
    } as never);
    const fetchSpy = jest.spyOn(global, 'fetch');
    await expect(provider.getRoute(coordinate, coordinate)).rejects.toThrow(
      'Google Routes is not configured',
    );
    expect(fetchSpy).not.toHaveBeenCalled();
  });
});
