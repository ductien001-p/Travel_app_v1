-- Read-only itinerary share links; only the SHA-256 of each token is stored.
CREATE TABLE "TripShareLink" (
    "id" TEXT NOT NULL,
    "tripId" TEXT NOT NULL,
    "createdById" TEXT NOT NULL,
    "tokenHash" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "revokedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TripShareLink_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "TripShareLink_tokenHash_key" ON "TripShareLink"("tokenHash");
CREATE INDEX "TripShareLink_tripId_idx" ON "TripShareLink"("tripId");
CREATE INDEX "TripShareLink_createdById_idx" ON "TripShareLink"("createdById");

ALTER TABLE "TripShareLink" ADD CONSTRAINT "TripShareLink_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "trips"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "TripShareLink" ADD CONSTRAINT "TripShareLink_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
