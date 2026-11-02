/*
  Warnings:

  - The values [ACTIVE,FULL] on the enum `TRIP_STATUS` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `country` on the `trips` table. All the data in the column will be lost.
  - You are about to drop the column `destination` on the `trips` table. All the data in the column will be lost.
  - You are about to drop the column `destinationLat` on the `trips` table. All the data in the column will be lost.
  - You are about to drop the column `destinationLng` on the `trips` table. All the data in the column will be lost.
  - You are about to drop the column `endTime` on the `trips` table. All the data in the column will be lost.
  - You are about to drop the column `isCompleted` on the `trips` table. All the data in the column will be lost.
  - You are about to drop the column `objectKey` on the `trips` table. All the data in the column will be lost.
  - You are about to drop the column `startTime` on the `trips` table. All the data in the column will be lost.
  - You are about to drop the column `title` on the `trips` table. All the data in the column will be lost.
  - You are about to drop the column `url` on the `trips` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[userId,placeId,tripId]` on the table `PlaceVisit` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `tripDestinationId` to the `TripPlace` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "TRIP_STATUS_new" AS ENUM ('ONGOING', 'OPEN', 'CANCELLED', 'COMPLETED', 'NOTCOMPLETED');
ALTER TABLE "public"."trips" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "trips" ALTER COLUMN "status" TYPE "TRIP_STATUS_new" USING ("status"::text::"TRIP_STATUS_new");
ALTER TYPE "TRIP_STATUS" RENAME TO "TRIP_STATUS_old";
ALTER TYPE "TRIP_STATUS_new" RENAME TO "TRIP_STATUS";
DROP TYPE "public"."TRIP_STATUS_old";
ALTER TABLE "trips" ALTER COLUMN "status" SET DEFAULT 'OPEN';
COMMIT;

-- DropForeignKey
ALTER TABLE "trips" DROP CONSTRAINT "trips_ownerId_fkey";

-- DropIndex
DROP INDEX "trips_destination_idx";

-- AlterTable
ALTER TABLE "PlaceVisit" ALTER COLUMN "tripId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "TripPlace" ADD COLUMN     "tripDestinationId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "trips" DROP COLUMN "country",
DROP COLUMN "destination",
DROP COLUMN "destinationLat",
DROP COLUMN "destinationLng",
DROP COLUMN "endTime",
DROP COLUMN "isCompleted",
DROP COLUMN "objectKey",
DROP COLUMN "startTime",
DROP COLUMN "title",
DROP COLUMN "url",
ALTER COLUMN "ownerId" DROP NOT NULL;

-- CreateTable
CREATE TABLE "TripDestination" (
    "id" TEXT NOT NULL,
    "tripId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "country" TEXT,
    "lat" DOUBLE PRECISION,
    "lng" DOUBLE PRECISION,
    "order" INTEGER NOT NULL,
    "startDate" TIMESTAMP(3),
    "endDate" TIMESTAMP(3),

    CONSTRAINT "TripDestination_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "TripDestination_tripId_idx" ON "TripDestination"("tripId");

-- CreateIndex
CREATE INDEX "TripDestination_tripId_order_idx" ON "TripDestination"("tripId", "order");

-- CreateIndex
CREATE UNIQUE INDEX "PlaceVisit_userId_placeId_tripId_key" ON "PlaceVisit"("userId", "placeId", "tripId");

-- AddForeignKey
ALTER TABLE "trips" ADD CONSTRAINT "trips_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripDestination" ADD CONSTRAINT "TripDestination_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "trips"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripPlace" ADD CONSTRAINT "TripPlace_tripDestinationId_fkey" FOREIGN KEY ("tripDestinationId") REFERENCES "TripDestination"("id") ON DELETE SET NULL ON UPDATE CASCADE;
