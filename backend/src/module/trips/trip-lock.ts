import { Prisma } from '../../generated/prisma/client';

/** Serialises publish, close and reopen for every trip of one owner. */
export async function lockRecruitmentOwner(
  tx: Prisma.TransactionClient,
  ownerId: string,
): Promise<void> {
  await tx.$queryRaw`
    SELECT pg_advisory_xact_lock(hashtextextended(${ownerId}, 0))
  `;
}

/**
 * Locks the trip row until the surrounding transaction ends, so concurrent
 * writers on the same trip (check-ins, membership, itinerary edits) run one at
 * a time. Returns false when the trip does not exist.
 */
export async function lockTripRow(
  tx: Prisma.TransactionClient,
  tripId: string,
): Promise<boolean> {
  const rows = await tx.$queryRaw<Array<{ id: string }>>`
    SELECT id FROM "trips" WHERE id = ${tripId} FOR UPDATE
  `;
  return rows.length > 0;
}
