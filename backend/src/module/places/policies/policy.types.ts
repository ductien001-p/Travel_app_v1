export const PLACE_RADIUS_KM = [1, 5, 10] as const;

export type PlaceRadiusKm = (typeof PLACE_RADIUS_KM)[number];

export type PlaceCollectionVisibilityName = 'PRIVATE' | 'PUBLIC';

export type PlaceCollectionAction =
  'READ' | 'UPDATE' | 'DELETE' | 'MANAGE_ITEMS' | 'RATE' | 'COPY';
