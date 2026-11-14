import { Injectable, ServiceUnavailableException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Coordinate, RouteProvider, RouteResult } from './route.types';

const GOOGLE_ROUTES_TIMEOUT_MS = 5000;

interface GoogleRoutesResponse {
  routes?: Array<{
    distanceMeters?: number;
    duration?: string;
    polyline?: { encodedPolyline?: string };
  }>;
}

@Injectable()
export class GoogleRoutesProvider implements RouteProvider {
  constructor(private readonly config: ConfigService) {}

  isConfigured(): boolean {
    return Boolean(this.config.get<string>('GOOGLE_ROUTES_API_KEY'));
  }

  async getRoute(
    origin: Coordinate,
    destination: Coordinate,
  ): Promise<RouteResult> {
    const apiKey = this.config.get<string>('GOOGLE_ROUTES_API_KEY');
    if (!apiKey) {
      throw new ServiceUnavailableException('Google Routes is not configured');
    }

    let response: Response;
    try {
      response = await fetch(
        'https://routes.googleapis.com/directions/v2:computeRoutes',
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-Api-Key': apiKey,
            'X-Goog-FieldMask':
              'routes.distanceMeters,routes.duration,routes.polyline.encodedPolyline',
          },
          body: JSON.stringify({
            origin: { location: { latLng: origin } },
            destination: { location: { latLng: destination } },
            travelMode: 'DRIVE',
            routingPreference: 'TRAFFIC_AWARE',
            polylineQuality: 'HIGH_QUALITY',
          }),
          signal: AbortSignal.timeout(GOOGLE_ROUTES_TIMEOUT_MS),
        },
      );
    } catch {
      throw new ServiceUnavailableException('Google Routes is unreachable');
    }

    if (!response.ok) {
      throw new ServiceUnavailableException(
        `Google Routes request failed with status ${response.status}`,
      );
    }

    const payload = (await response.json()) as GoogleRoutesResponse;
    const route = payload.routes?.[0];
    const durationSeconds = this.parseDuration(route?.duration);
    if (
      route?.distanceMeters == null ||
      durationSeconds == null ||
      !route.polyline?.encodedPolyline
    ) {
      throw new ServiceUnavailableException(
        'Google Routes returned no usable driving route',
      );
    }

    return {
      distanceMeters: route.distanceMeters,
      durationSeconds,
      polyline: route.polyline.encodedPolyline,
    };
  }

  private parseDuration(value?: string): number | null {
    if (!value?.endsWith('s')) return null;
    const seconds = Number(value.slice(0, -1));
    return Number.isFinite(seconds) ? Math.round(seconds) : null;
  }
}
