/*
  Warnings:

  - A unique constraint covering the columns `[tripId,dayNumber]` on the table `ItineraryDay` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `tripId` to the `ItineraryDay` table without a default value. This is not possible if the table is not empty.
  - Made the column `date` on table `ItineraryDay` required. This step will fail if there are existing NULL values in that column.

*/
-- DropIndex
DROP INDEX "ItineraryDay_destinationId_dayNumber_key";

-- AlterTable
ALTER TABLE "ItineraryDay" ADD COLUMN     "tripId" TEXT NOT NULL,
ALTER COLUMN "date" SET NOT NULL;

-- CreateIndex
CREATE INDEX "ItineraryDay_tripId_idx" ON "ItineraryDay"("tripId");

-- CreateIndex
CREATE INDEX "ItineraryDay_tripId_date_idx" ON "ItineraryDay"("tripId", "date");

-- CreateIndex
CREATE UNIQUE INDEX "ItineraryDay_tripId_dayNumber_key" ON "ItineraryDay"("tripId", "dayNumber");

-- AddForeignKey
ALTER TABLE "ItineraryDay" ADD CONSTRAINT "ItineraryDay_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "trips"("id") ON DELETE CASCADE ON UPDATE CASCADE;
