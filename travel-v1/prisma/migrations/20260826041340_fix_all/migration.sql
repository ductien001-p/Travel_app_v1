/*
  Warnings:

  - You are about to drop the column `activityId` on the `TripCheckin` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `TripDestination` table. All the data in the column will be lost.
  - You are about to drop the column `isDominant` on the `UserTravelDNA` table. All the data in the column will be lost.
  - You are about to drop the `ItineraryActivity` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TripItinerary` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[source,externalId]` on the table `Place` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[destinationId,memberId]` on the table `TripCheckin` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `destinationId` to the `ItineraryDay` table without a default value. This is not possible if the table is not empty.
  - Added the required column `country` to the `Place` table without a default value. This is not possible if the table is not empty.
  - Added the required column `destinationId` to the `TripCheckin` table without a default value. This is not possible if the table is not empty.
  - Added the required column `city` to the `TripDestination` table without a default value. This is not possible if the table is not empty.
  - Made the column `country` on table `TripDestination` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "ItineraryActivity" DROP CONSTRAINT "ItineraryActivity_dayId_fkey";

-- DropForeignKey
ALTER TABLE "ItineraryActivity" DROP CONSTRAINT "ItineraryActivity_placeId_fkey";

-- DropForeignKey
ALTER TABLE "ItineraryDay" DROP CONSTRAINT "ItineraryDay_itineraryId_fkey";

-- DropForeignKey
ALTER TABLE "TripCheckin" DROP CONSTRAINT "TripCheckin_activityId_fkey";

-- DropForeignKey
ALTER TABLE "TripItinerary" DROP CONSTRAINT "TripItinerary_tripId_fkey";

-- DropIndex
DROP INDEX "TripCheckin_activityId_memberId_key";

-- AlterTable
ALTER TABLE "ItineraryDay" ADD COLUMN     "destinationId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Place" ADD COLUMN     "country" TEXT NOT NULL,
ADD COLUMN     "externalId" TEXT;

-- AlterTable
ALTER TABLE "TripCheckin" DROP COLUMN "activityId",
ADD COLUMN     "destinationId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "TripDestination" DROP COLUMN "name",
ADD COLUMN     "city" TEXT NOT NULL,
ALTER COLUMN "country" SET NOT NULL;

-- AlterTable
ALTER TABLE "UserTravelDNA" DROP COLUMN "isDominant",
ADD COLUMN     "activityCount" INTEGER NOT NULL DEFAULT 0;

-- DropTable
DROP TABLE "ItineraryActivity";

-- DropTable
DROP TABLE "TripItinerary";

-- DropEnum
DROP TYPE "ACTIVITY_TYPE";

-- CreateTable
CREATE TABLE "ItineraryItem" (
    "id" TEXT NOT NULL,
    "dayId" TEXT NOT NULL,
    "placeId" TEXT,
    "title" TEXT NOT NULL,
    "placeName" TEXT,
    "startTime" TIMESTAMP(3),
    "estimatedDuration" INTEGER,
    "estimatedCost" DECIMAL(12,2),
    "isCheckin" BOOLEAN NOT NULL DEFAULT false,
    "orderIndex" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ItineraryItem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ItineraryItem_dayId_idx" ON "ItineraryItem"("dayId");

-- CreateIndex
CREATE INDEX "ItineraryItem_dayId_orderIndex_idx" ON "ItineraryItem"("dayId", "orderIndex");

-- CreateIndex
CREATE UNIQUE INDEX "Place_source_externalId_key" ON "Place"("source", "externalId");

-- CreateIndex
CREATE UNIQUE INDEX "TripCheckin_destinationId_memberId_key" ON "TripCheckin"("destinationId", "memberId");

-- AddForeignKey
ALTER TABLE "ItineraryDay" ADD CONSTRAINT "ItineraryDay_destinationId_fkey" FOREIGN KEY ("destinationId") REFERENCES "TripDestination"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ItineraryItem" ADD CONSTRAINT "ItineraryItem_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ItineraryItem" ADD CONSTRAINT "ItineraryItem_dayId_fkey" FOREIGN KEY ("dayId") REFERENCES "ItineraryDay"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripCheckin" ADD CONSTRAINT "TripCheckin_destinationId_fkey" FOREIGN KEY ("destinationId") REFERENCES "ItineraryItem"("id") ON DELETE CASCADE ON UPDATE CASCADE;
