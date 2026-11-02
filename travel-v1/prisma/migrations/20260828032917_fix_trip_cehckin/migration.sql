/*
  Warnings:

  - You are about to drop the column `description` on the `TripCheckin` table. All the data in the column will be lost.
  - You are about to drop the column `destinationId` on the `TripCheckin` table. All the data in the column will be lost.
  - You are about to drop the column `photoUrl` on the `TripCheckin` table. All the data in the column will be lost.
  - You are about to drop the column `placeName` on the `TripCheckin` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[activityId,memberId]` on the table `TripCheckin` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `activityId` to the `TripCheckin` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "TripCheckin" DROP CONSTRAINT "TripCheckin_destinationId_fkey";

-- DropIndex
DROP INDEX "TripCheckin_destinationId_memberId_key";

-- AlterTable
ALTER TABLE "TripCheckin" DROP COLUMN "description",
DROP COLUMN "destinationId",
DROP COLUMN "photoUrl",
DROP COLUMN "placeName",
ADD COLUMN     "activityId" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "TripCheckin_activityId_memberId_key" ON "TripCheckin"("activityId", "memberId");

-- AddForeignKey
ALTER TABLE "TripCheckin" ADD CONSTRAINT "TripCheckin_activityId_fkey" FOREIGN KEY ("activityId") REFERENCES "ItineraryItem"("id") ON DELETE CASCADE ON UPDATE CASCADE;
