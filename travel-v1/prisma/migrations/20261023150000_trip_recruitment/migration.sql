-- CreateEnum
CREATE TYPE "RECRUITMENT_STATE" AS ENUM ('NOT_PUBLISHED', 'OPEN', 'FULL', 'CLOSED');

-- CreateEnum
CREATE TYPE "RECRUITMENT_ORIGIN" AS ENUM ('PUBLISH_WIZARD', 'EXISTING_TRIP', 'LEGACY_BACKFILL');

-- AlterEnum
ALTER TYPE "TIMELINE_EVENT_TYPE" ADD VALUE 'TRIP_PUBLISHED';

-- AlterEnum
ALTER TYPE "NOTIFICATION_TYPE" ADD VALUE 'TRIP_RECRUITMENT_CLOSED';
ALTER TYPE "NOTIFICATION_TYPE" ADD VALUE 'TRIP_RECRUITMENT_DATES_CHANGED';
ALTER TYPE "NOTIFICATION_TYPE" ADD VALUE 'TRIP_RECRUITMENT_INCOMPLETE';

-- CreateTable
CREATE TABLE "trip_recruitments" (
    "tripId" TEXT NOT NULL,
    "state" "RECRUITMENT_STATE" NOT NULL,
    "requirements" TEXT,
    "estimatedBudgetPerPerson" DECIMAL(14,2),
    "publishedAt" TIMESTAMP(3),
    "expiresAt" TIMESTAMP(3),
    "draftStep" INTEGER,
    "origin" "RECRUITMENT_ORIGIN" NOT NULL,
    "previousVisibility" "TRIP_VISIBILITY",
    "notifiedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "trip_recruitments_pkey" PRIMARY KEY ("tripId")
);

-- CreateTable
CREATE TABLE "trip_publish_idempotency" (
    "id" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "tripId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "trip_publish_idempotency_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "trip_recruitments_state_expiresAt_idx" ON "trip_recruitments"("state", "expiresAt");

-- CreateIndex
CREATE INDEX "trip_publish_idempotency_createdAt_idx" ON "trip_publish_idempotency"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "trip_publish_idempotency_ownerId_key_key" ON "trip_publish_idempotency"("ownerId", "key");

-- AddForeignKey
ALTER TABLE "trip_recruitments" ADD CONSTRAINT "trip_recruitments_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "trips"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trip_publish_idempotency" ADD CONSTRAINT "trip_publish_idempotency_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trip_publish_idempotency" ADD CONSTRAINT "trip_publish_idempotency_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "trips"("id") ON DELETE CASCADE ON UPDATE CASCADE;
