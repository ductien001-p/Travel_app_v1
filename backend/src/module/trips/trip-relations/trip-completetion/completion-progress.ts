import { Prisma } from '../../../../generated/prisma/client';

const POINTS_PER_CHECKIN = 5;

export type CompletionProgress = {
  totalPlaces: number;
  checkinCount: number;
};

type ProgressReader = Pick<
  Prisma.TransactionClient,
  'itineraryItem' | 'tripCheckin'
>;

export function completionPoints(checkinCount: number): number {
  return checkinCount * POINTS_PER_CHECKIN;
}

/** Counts the distinct itinerary places and how many of them the user checked in at. */
export async function countCompletionProgress(
  reader: ProgressReader,
  tripId: string,
  userId: string,
): Promise<CompletionProgress> {
  // Sequential on purpose: the reader may be an interactive transaction.
  const itineraryPlaces = await reader.itineraryItem.findMany({
    where: { tripId },
    distinct: ['placeId'],
    select: { placeId: true },
  });
  const checkins = await reader.tripCheckin.findMany({
    where: { tripId, userId },
    distinct: ['placeId'],
    select: { placeId: true },
  });
  const itineraryPlaceIds = new Set(
    itineraryPlaces.map((item) => item.placeId),
  );
  const checkinCount = checkins.filter((checkin) =>
    itineraryPlaceIds.has(checkin.placeId),
  ).length;

  return { totalPlaces: itineraryPlaceIds.size, checkinCount };
}
