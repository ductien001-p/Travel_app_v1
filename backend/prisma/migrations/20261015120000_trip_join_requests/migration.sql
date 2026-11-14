-- Joining with the invite code now asks OWNER/ADMIN for approval instead of
-- adding the member right away. Requests from the owner's friends can be
-- approved automatically (off by default, so existing trips keep reviewing).
-- CreateEnum
CREATE TYPE "JOIN_REQUEST_STATUS" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- AlterEnum (several values in one migration needs PostgreSQL 12+)
ALTER TYPE "NOTIFICATION_TYPE" ADD VALUE 'TRIP_JOIN_REQUEST';
ALTER TYPE "NOTIFICATION_TYPE" ADD VALUE 'TRIP_JOIN_REQUEST_APPROVED';
ALTER TYPE "NOTIFICATION_TYPE" ADD VALUE 'TRIP_JOIN_REQUEST_REJECTED';

-- AlterTable
ALTER TABLE "trips" ADD COLUMN     "autoApproveFriends" BOOLEAN NOT NULL DEFAULT false;

-- CreateTable
CREATE TABLE "trip_join_requests" (
    "id" TEXT NOT NULL,
    "tripId" TEXT NOT NULL,
    "requesterId" TEXT NOT NULL,
    "status" "JOIN_REQUEST_STATUS" NOT NULL DEFAULT 'PENDING',
    "message" VARCHAR(500),
    "decidedById" TEXT,
    "decidedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "trip_join_requests_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "trip_join_requests_tripId_status_createdAt_idx" ON "trip_join_requests"("tripId", "status", "createdAt");

-- CreateIndex
CREATE INDEX "trip_join_requests_requesterId_idx" ON "trip_join_requests"("requesterId");

-- CreateIndex
CREATE INDEX "trip_join_requests_decidedById_idx" ON "trip_join_requests"("decidedById");

-- CreateIndex
CREATE UNIQUE INDEX "trip_join_requests_tripId_requesterId_key" ON "trip_join_requests"("tripId", "requesterId");

-- AddForeignKey
ALTER TABLE "trip_join_requests" ADD CONSTRAINT "trip_join_requests_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "trips"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trip_join_requests" ADD CONSTRAINT "trip_join_requests_requesterId_fkey" FOREIGN KEY ("requesterId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trip_join_requests" ADD CONSTRAINT "trip_join_requests_decidedById_fkey" FOREIGN KEY ("decidedById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
