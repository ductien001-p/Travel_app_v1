-- Memory photos get a context badge (night, scenery, people, food) suggested by
-- a vision model in the background. Existing photos stay pending
-- (badgeCheckedAt NULL) so the backfill job classifies them too.
CREATE TYPE "MEMORY_BADGE" AS ENUM ('NIGHT', 'SCENERY', 'PEOPLE', 'FOOD');

ALTER TABLE "TripMedia"
    ADD COLUMN "badge" "MEMORY_BADGE",
    ADD COLUMN "badgeCheckedAt" TIMESTAMP(3);

CREATE INDEX "TripMedia_tripId_createdAt_idx" ON "TripMedia"("tripId", "createdAt");
CREATE INDEX "TripMedia_badgeCheckedAt_createdAt_idx" ON "TripMedia"("badgeCheckedAt", "createdAt");
