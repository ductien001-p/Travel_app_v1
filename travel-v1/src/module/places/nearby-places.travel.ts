const WALK_MAX_KM = 1.5;
const WALK_KMH = 5;
const DRIVE_KMH = 25;

export function travelEstimate(distanceKm: number): {
  travelMode: 'walk' | 'drive';
  travelMinutes: number;
} {
  const walk = distanceKm <= WALK_MAX_KM;
  const speed = walk ? WALK_KMH : DRIVE_KMH;
  return {
    travelMode: walk ? 'walk' : 'drive',
    travelMinutes: Math.max(1, Math.round((distanceKm / speed) * 60)),
  };
}

export function boundingBox(
  latitude: number,
  longitude: number,
  radiusKm: number,
) {
  const latDelta = radiusKm / 111;
  const cosine = Math.cos((latitude * Math.PI) / 180);
  const safeCosine = Math.abs(cosine) < 0.01 ? 0.01 : cosine;
  const lngDelta = radiusKm / (111 * safeCosine);
  return {
    minLat: latitude - latDelta,
    maxLat: latitude + latDelta,
    minLng: longitude - lngDelta,
    maxLng: longitude + lngDelta,
  };
}
