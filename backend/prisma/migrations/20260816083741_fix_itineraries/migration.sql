/*
  Warnings:

  - A unique constraint covering the columns `[itineraryId,dayNumber]` on the table `ItineraryDay` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[tripId]` on the table `TripItinerary` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `createdBy` to the `ItineraryActivity` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `ItineraryActivity` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `ItineraryDay` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `TripItinerary` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ItineraryActivity" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "createdBy" TEXT NOT NULL,
ADD COLUMN     "estimatedCost" DECIMAL(12,2),
ADD COLUMN     "title" TEXT,
ADD COLUMN     "type" TEXT,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "orderIndex" SET DEFAULT 0,
ALTER COLUMN "orderIndex" SET DATA TYPE DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "ItineraryDay" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "TripItinerary" ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "ItineraryDay_itineraryId_dayNumber_key" ON "ItineraryDay"("itineraryId", "dayNumber");

-- CreateIndex
CREATE UNIQUE INDEX "TripItinerary_tripId_key" ON "TripItinerary"("tripId");
