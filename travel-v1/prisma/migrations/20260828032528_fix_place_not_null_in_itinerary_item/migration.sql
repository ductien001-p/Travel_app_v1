/*
  Warnings:

  - You are about to drop the column `placeName` on the `ItineraryItem` table. All the data in the column will be lost.
  - Made the column `placeId` on table `ItineraryItem` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "ItineraryItem" DROP COLUMN "placeName",
ALTER COLUMN "placeId" SET NOT NULL;
