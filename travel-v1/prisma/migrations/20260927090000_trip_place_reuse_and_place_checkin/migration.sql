-- Permit the same Place to appear in multiple itinerary items.
DROP INDEX IF EXISTS "ItineraryItem_tripId_placeId_key";
CREATE INDEX IF NOT EXISTS "ItineraryItem_tripId_placeId_idx"
  ON "ItineraryItem"("tripId", "placeId");

-- Backfill the place-level check-in identity from existing relations first.
ALTER TABLE "TripCheckin"
  ADD COLUMN "tripId" TEXT,
  ADD COLUMN "userId" TEXT,
  ADD COLUMN "placeId" TEXT;

UPDATE "TripCheckin" AS checkin
SET
  "tripId" = item."tripId",
  "placeId" = item."placeId",
  "userId" = member."userId"
FROM "ItineraryItem" AS item, "trip_members" AS member
WHERE checkin."activityId" = item."id"
  AND checkin."memberId" = member."id";

DO $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM "TripCheckin"
    WHERE "tripId" IS NULL OR "userId" IS NULL OR "placeId" IS NULL
  ) THEN
    RAISE EXCEPTION 'TripCheckin backfill failed because an activity or member relation is missing';
  END IF;
END $$;

-- Historical data could contain one check-in per duplicate activity. Keep the
-- oldest check-in for each Trip/User/Place and remove only redundant rows.
CREATE TEMP TABLE "_duplicate_trip_checkins" ("id" TEXT PRIMARY KEY) ON COMMIT DROP;
INSERT INTO "_duplicate_trip_checkins" ("id")
SELECT "id"
FROM (
  SELECT
    "id",
    ROW_NUMBER() OVER (
      PARTITION BY "tripId", "userId", "placeId"
      ORDER BY "visitedAt" ASC, "createdAt" ASC, "id" ASC
    ) AS duplicate_number
  FROM "TripCheckin"
) ranked
WHERE duplicate_number > 1;

DELETE FROM "TravelDNAEvent"
WHERE "checkinId" IN (SELECT "id" FROM "_duplicate_trip_checkins");

DELETE FROM "TripCheckin"
WHERE "id" IN (SELECT "id" FROM "_duplicate_trip_checkins");

ALTER TABLE "TripCheckin"
  ALTER COLUMN "tripId" SET NOT NULL,
  ALTER COLUMN "userId" SET NOT NULL,
  ALTER COLUMN "placeId" SET NOT NULL;

DROP INDEX IF EXISTS "TripCheckin_activityId_memberId_key";
DROP INDEX IF EXISTS "TripCheckin_tripId_userId_placeId_key";
ALTER TABLE "TripCheckin" DROP CONSTRAINT IF EXISTS "TripCheckin_activityId_fkey";
ALTER TABLE "TripCheckin" ALTER COLUMN "activityId" DROP NOT NULL;

CREATE UNIQUE INDEX "TripCheckin_tripId_userId_placeId_key"
  ON "TripCheckin"("tripId", "userId", "placeId");
CREATE INDEX "TripCheckin_activityId_idx" ON "TripCheckin"("activityId");

ALTER TABLE "TripCheckin"
  ADD CONSTRAINT "TripCheckin_tripId_fkey"
    FOREIGN KEY ("tripId") REFERENCES "trips"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT "TripCheckin_userId_fkey"
    FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT "TripCheckin_placeId_fkey"
    FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT "TripCheckin_activityId_fkey"
    FOREIGN KEY ("activityId") REFERENCES "ItineraryItem"("id") ON DELETE SET NULL ON UPDATE CASCADE;
