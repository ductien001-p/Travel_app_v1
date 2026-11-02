/*
  Warnings:

  - You are about to drop the column `tripId` on the `TripCheckin` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "TripCheckin" DROP CONSTRAINT "TripCheckin_tripId_fkey";

-- DropIndex
DROP INDEX "TripCheckin_tripId_idx";

-- DropIndex
DROP INDEX "TripCheckin_tripId_memberId_createdAt_idx";

-- AlterTable
ALTER TABLE "TripCheckin" DROP COLUMN "tripId";

-- CreateIndex
CREATE INDEX "TripCheckin_memberId_createdAt_idx" ON "TripCheckin"("memberId", "createdAt");
