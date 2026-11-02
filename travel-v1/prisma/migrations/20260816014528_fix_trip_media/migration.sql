/*
  Warnings:

  - You are about to drop the column `orderIndex` on the `TripMedia` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[mediaId]` on the table `TripMedia` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "UploadedMedia" DROP CONSTRAINT "UploadedMedia_userId_fkey";

-- DropIndex
DROP INDEX "TripItinerary_tripId_idx";

-- DropIndex
DROP INDEX "TripMedia_tripId_orderIndex_idx";

-- AlterTable
ALTER TABLE "TripMedia" DROP COLUMN "orderIndex",
ADD COLUMN     "caption" TEXT;

-- AlterTable
ALTER TABLE "UploadedMedia" ADD COLUMN     "deletedAt" TIMESTAMP(3),
ALTER COLUMN "userId" DROP NOT NULL;

-- CreateIndex
CREATE INDEX "TripItinerary_tripId_createdAt_idx" ON "TripItinerary"("tripId", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "TripMedia_mediaId_key" ON "TripMedia"("mediaId");

-- CreateIndex
CREATE INDEX "TripMedia_tripId_idx" ON "TripMedia"("tripId");

-- AddForeignKey
ALTER TABLE "UploadedMedia" ADD CONSTRAINT "UploadedMedia_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
