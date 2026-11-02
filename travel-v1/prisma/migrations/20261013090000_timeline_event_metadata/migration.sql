-- Timeline events keep a per-type snapshot so the feed can render details
-- (amount, place, photos...) without joining resources that may change or be deleted.
CREATE TYPE "TIMELINE_TARGET_TYPE" AS ENUM ('TRIP', 'MEMBER', 'ACTIVITY', 'EXPENSE', 'MEMORY');

ALTER TABLE "TripTimelineEvent"
    ADD COLUMN "metadata" JSONB,
    ADD COLUMN "targetType" "TIMELINE_TARGET_TYPE",
    ADD COLUMN "targetId" TEXT;

CREATE INDEX "TripTimelineEvent_tripId_type_createdAt_idx" ON "TripTimelineEvent"("tripId", "type", "createdAt");
