-- Keep one row per (tripId, interestId) before enforcing uniqueness.
DELETE FROM "TripInterest" AS duplicate
USING "TripInterest" AS kept
WHERE duplicate."tripId" = kept."tripId"
  AND duplicate."interestId" = kept."interestId"
  AND duplicate."id" > kept."id";

-- CreateIndex
CREATE UNIQUE INDEX "TripInterest_tripId_interestId_key" ON "TripInterest"("tripId", "interestId");
