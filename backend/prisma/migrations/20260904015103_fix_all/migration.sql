/*
  Warnings:

  - The values [BRIDGE,HARBOR] on the enum `PLACE_CATEGORY` will be removed. If these variants are still used in the database, this will fail.
  - The values [ROAD_TRIPPER] on the enum `TRAVEL_DNA_TYPE` will be removed. If these variants are still used in the database, this will fail.
  - The values [ROAD_TRIP] on the enum `TRIP_TYPE` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `tripCount` on the `UserTravelDNA` table. All the data in the column will be lost.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "PLACE_CATEGORY_new" AS ENUM ('FOOD', 'CAFE', 'HOTEL', 'RESORT', 'HOSTEL', 'HOMESTAY', 'VILLA', 'MOUNTAIN', 'BEACH', 'CAVE', 'WATERFALL', 'LAKE', 'CAMPING', 'MUSEUM', 'TEMPLES', 'CHURCH', 'HISTORICAL_SITE', 'MONUMENT', 'PALACE', 'CASTLE', 'OLD_TOWN', 'ZOO', 'WATER_PARK', 'PARK', 'CINEMA', 'THEATER', 'NIGHT_MARKET', 'SHOPPING_MALL', 'MARKET', 'ZIPLINE', 'WALKING_STREET');
ALTER TABLE "Place" ALTER COLUMN "category" TYPE "PLACE_CATEGORY_new" USING ("category"::text::"PLACE_CATEGORY_new");
ALTER TYPE "PLACE_CATEGORY" RENAME TO "PLACE_CATEGORY_old";
ALTER TYPE "PLACE_CATEGORY_new" RENAME TO "PLACE_CATEGORY";
DROP TYPE "public"."PLACE_CATEGORY_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "TRAVEL_DNA_TYPE_new" AS ENUM ('SOLO_TRAVELER', 'FAMILY_TRAVELER', 'COUPLE_TRAVELLER', 'GROUP_TRAVELER', 'BACKPACKER', 'MOUNTAIN_LOVER', 'BEACH_LOVER', 'ADVENTURE_TRAVELER', 'FOODIE_TRAVELER', 'CULTURE_TRAVELER', 'ENTERTAINMENT_TRAVELLER', 'PHOTOGRAPHY_LOVER');
ALTER TABLE "UserTravelDNA" ALTER COLUMN "type" TYPE "TRAVEL_DNA_TYPE_new" USING ("type"::text::"TRAVEL_DNA_TYPE_new");
ALTER TYPE "TRAVEL_DNA_TYPE" RENAME TO "TRAVEL_DNA_TYPE_old";
ALTER TYPE "TRAVEL_DNA_TYPE_new" RENAME TO "TRAVEL_DNA_TYPE";
DROP TYPE "public"."TRAVEL_DNA_TYPE_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "TRIP_TYPE_new" AS ENUM ('SOLO', 'COUPLE', 'FAMILY', 'FRIENDS', 'BACKPACKER', 'OTHER');
ALTER TABLE "public"."trips" ALTER COLUMN "tripType" DROP DEFAULT;
ALTER TABLE "trips" ALTER COLUMN "tripType" TYPE "TRIP_TYPE_new" USING ("tripType"::text::"TRIP_TYPE_new");
ALTER TYPE "TRIP_TYPE" RENAME TO "TRIP_TYPE_old";
ALTER TYPE "TRIP_TYPE_new" RENAME TO "TRIP_TYPE";
DROP TYPE "public"."TRIP_TYPE_old";
ALTER TABLE "trips" ALTER COLUMN "tripType" SET DEFAULT 'OTHER';
COMMIT;

-- AlterTable
ALTER TABLE "UserTravelDNA" DROP COLUMN "tripCount",
ADD COLUMN     "tripTypeCount" INTEGER NOT NULL DEFAULT 0;

-- CreateTable
CREATE TABLE "UserTravelStats" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "totalTrips" INTEGER NOT NULL DEFAULT 0,
    "totalActivities" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserTravelStats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TravelDNAEvent" (
    "id" TEXT NOT NULL,
    "checkinId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TravelDNAEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "UserTravelStats_userId_key" ON "UserTravelStats"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "TravelDNAEvent_checkinId_key" ON "TravelDNAEvent"("checkinId");

-- CreateIndex
CREATE INDEX "TravelDNAEvent_userId_idx" ON "TravelDNAEvent"("userId");

-- AddForeignKey
ALTER TABLE "UserTravelStats" ADD CONSTRAINT "UserTravelStats_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
