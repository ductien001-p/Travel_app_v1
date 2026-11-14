/*
  Warnings:

  - You are about to drop the column `itineraryId` on the `ItineraryDay` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[destinationId,dayNumber]` on the table `ItineraryDay` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "ItineraryDay_itineraryId_dayNumber_idx";

-- DropIndex
DROP INDEX "ItineraryDay_itineraryId_dayNumber_key";

-- DropIndex
DROP INDEX "ItineraryDay_itineraryId_idx";

-- AlterTable
ALTER TABLE "ItineraryDay" DROP COLUMN "itineraryId";

-- CreateIndex
CREATE INDEX "ItineraryDay_destinationId_idx" ON "ItineraryDay"("destinationId");

-- CreateIndex
CREATE UNIQUE INDEX "ItineraryDay_destinationId_dayNumber_key" ON "ItineraryDay"("destinationId", "dayNumber");
