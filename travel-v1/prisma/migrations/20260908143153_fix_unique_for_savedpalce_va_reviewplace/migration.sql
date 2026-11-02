/*
  Warnings:

  - You are about to drop the `PlaceVisit` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[tripId,placeId]` on the table `ItineraryItem` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userId,placeId]` on the table `PlaceReview` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[tripId,mediaId]` on the table `TripMedia` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `tripId` to the `ItineraryItem` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "ItineraryDay" DROP CONSTRAINT "ItineraryDay_destinationId_fkey";

-- DropForeignKey
ALTER TABLE "PlaceVisit" DROP CONSTRAINT "PlaceVisit_placeId_fkey";

-- DropForeignKey
ALTER TABLE "PlaceVisit" DROP CONSTRAINT "PlaceVisit_tripId_fkey";

-- DropForeignKey
ALTER TABLE "PlaceVisit" DROP CONSTRAINT "PlaceVisit_userId_fkey";

-- AlterTable
ALTER TABLE "ItineraryItem" ADD COLUMN     "tripId" TEXT NOT NULL;

-- DropTable
DROP TABLE "PlaceVisit";

-- CreateIndex
CREATE UNIQUE INDEX "ItineraryItem_tripId_placeId_key" ON "ItineraryItem"("tripId", "placeId");

-- CreateIndex
CREATE UNIQUE INDEX "PlaceReview_userId_placeId_key" ON "PlaceReview"("userId", "placeId");

-- CreateIndex
CREATE UNIQUE INDEX "TripMedia_tripId_mediaId_key" ON "TripMedia"("tripId", "mediaId");

-- AddForeignKey
ALTER TABLE "ItineraryDay" ADD CONSTRAINT "ItineraryDay_destinationId_fkey" FOREIGN KEY ("destinationId") REFERENCES "TripDestination"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ItineraryItem" ADD CONSTRAINT "ItineraryItem_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "trips"("id") ON DELETE CASCADE ON UPDATE CASCADE;
