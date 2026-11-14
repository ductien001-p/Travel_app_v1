export interface Coordinate {
  latitude: number;
  longitude: number;
}

export interface RouteResult {
  distanceMeters: number;
  durationSeconds: number;
  polyline: string | null;
}

export interface RouteProvider {
  getRoute(origin: Coordinate, destination: Coordinate): Promise<RouteResult>;
}

export const ROUTE_PROVIDER = Symbol('ROUTE_PROVIDER');
