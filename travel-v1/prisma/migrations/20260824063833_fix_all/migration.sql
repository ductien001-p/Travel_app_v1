/*
  Warnings:

  - The values [TRANSPORT,ACCOMMODATION,ACTIVITY] on the enum `ActivityType` will be removed. If these variants are still used in the database, this will fail.
  - The values [TOURIST_ATTRACTION,ENTERTAINMENT] on the enum `PlaceCategory` will be removed. If these variants are still used in the database, this will fail.
  - The values [BUSINESS] on the enum `TRIP_TYPE` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `userId` on the `TripCheckin` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `TripTimelineEvent` table. All the data in the column will be lost.
  - You are about to drop the column `travelStyle` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `reputationLevel` on the `UserRanking` table. All the data in the column will be lost.
  - You are about to drop the `UserBadge` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `memberId` to the `TripTimelineEvent` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ranking` to the `UserRanking` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "RANK" AS ENUM ('BEGINNER', 'EXPLORER', 'ADVENTURER', 'LEGEND');

-- CreateEnum
CREATE TYPE "TRAVEL_DNA_TYPE" AS ENUM ('SOLO_TRAVELER', 'BACKPACKER', 'MOUNTAIN_LOVER', 'BEACH_LOVER', 'ADVENTURE_TRAVELER', 'ROAD_TRIPPER', 'FOODIE_TRAVELER', 'PHOTOGRAPHY_LOVER', 'CULTURE_TRAVELER', 'FAMILY_TRAVELER', 'COUPLE_TRAVELLER', 'GROUP_TRAVELER');

-- CreateEnum
CREATE TYPE "AchievementCategory" AS ENUM ('EXPLORATION', 'CREATOR', 'ADVENTURE', 'SPECIAL');

-- AlterEnum
BEGIN;
CREATE TYPE "ActivityType_new" AS ENUM ('FOOD', 'PHOTOGRAPHY', 'ADVENTURE', 'SIGHTSEEING', 'EXPERIENCE');
ALTER TABLE "ItineraryActivity" ALTER COLUMN "type" TYPE "ActivityType_new" USING ("type"::text::"ActivityType_new");
ALTER TYPE "ActivityType" RENAME TO "ActivityType_old";
ALTER TYPE "ActivityType_new" RENAME TO "ActivityType";
DROP TYPE "public"."ActivityType_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "PlaceCategory_new" AS ENUM ('CAFE', 'RESTAURANT', 'FOOD', 'HOTEL', 'RESORT', 'HOSTEL', 'HOMESTAY', 'VILLA', 'CAMPING', 'MOUNTAIN', 'BEACH', 'CAVE', 'WATERFALL', 'PARK', 'LAKE', 'MUSEUM', 'TEMPLES', 'CHURCH', 'HISTORICAL_SITE', 'MONUMENT', 'PALACE', 'CASTLE', 'OLD_TOWN', 'ZOO', 'WATER_PARK', 'CINEMA', 'THEATER', 'NIGHT_MARKET', 'SHOPPING_MALL', 'MARKET', 'HIKING', 'TREKKING', 'SURFING', 'CLIMBING', 'ZIPLINE', 'CAMPING_SITE', 'BRIDGE', 'HARBOR', 'WALKING_STREET');
ALTER TABLE "Place" ALTER COLUMN "category" TYPE "PlaceCategory_new" USING ("category"::text::"PlaceCategory_new");
ALTER TYPE "PlaceCategory" RENAME TO "PlaceCategory_old";
ALTER TYPE "PlaceCategory_new" RENAME TO "PlaceCategory";
DROP TYPE "public"."PlaceCategory_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "TRIP_TYPE_new" AS ENUM ('SOLO', 'COUPLE', 'FAMILY', 'FRIENDS', 'ROAD_TRIP', 'OTHER');
ALTER TABLE "public"."trips" ALTER COLUMN "tripType" DROP DEFAULT;
ALTER TABLE "trips" ALTER COLUMN "tripType" TYPE "TRIP_TYPE_new" USING ("tripType"::text::"TRIP_TYPE_new");
ALTER TYPE "TRIP_TYPE" RENAME TO "TRIP_TYPE_old";
ALTER TYPE "TRIP_TYPE_new" RENAME TO "TRIP_TYPE";
DROP TYPE "public"."TRIP_TYPE_old";
ALTER TABLE "trips" ALTER COLUMN "tripType" SET DEFAULT 'OTHER';
COMMIT;

-- DropForeignKey
ALTER TABLE "TripCheckin" DROP CONSTRAINT "TripCheckin_userId_fkey";

-- DropForeignKey
ALTER TABLE "TripMessage" DROP CONSTRAINT "TripMessage_senderId_fkey";

-- DropForeignKey
ALTER TABLE "TripTimelineEvent" DROP CONSTRAINT "TripTimelineEvent_userId_fkey";

-- DropForeignKey
ALTER TABLE "UserBadge" DROP CONSTRAINT "UserBadge_userId_fkey";

-- DropIndex
DROP INDEX "TripTimelineEvent_userId_idx";

-- DropIndex
DROP INDEX "User_travelStyle_idx";

-- AlterTable
ALTER TABLE "TripCheckin" DROP COLUMN "userId";

-- AlterTable
ALTER TABLE "TripTimelineEvent" DROP COLUMN "userId",
ADD COLUMN     "memberId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "travelStyle";

-- AlterTable
ALTER TABLE "UserRanking" DROP COLUMN "reputationLevel",
ADD COLUMN     "rank" "RANK" NOT NULL DEFAULT 'BEGINNER',
ADD COLUMN     "ranking" INTEGER NOT NULL;

-- DropTable
DROP TABLE "UserBadge";

-- DropEnum
DROP TYPE "REPUTATION_LEVEL";

-- DropEnum
DROP TYPE "TravelStyle";

-- CreateTable
CREATE TABLE "UserTravelDNA" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" "TRAVEL_DNA_TYPE" NOT NULL,
    "score" INTEGER NOT NULL DEFAULT 0,
    "tripCount" INTEGER NOT NULL DEFAULT 0,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserTravelDNA_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Achievement" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "category" "AchievementCategory" NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Achievement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AchievementLevel" (
    "id" TEXT NOT NULL,
    "achievementId" TEXT NOT NULL,
    "level" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "requirement" INTEGER NOT NULL,

    CONSTRAINT "AchievementLevel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserAchievement" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "achievementId" TEXT NOT NULL,
    "progress" INTEGER NOT NULL DEFAULT 0,
    "currentLevel" INTEGER NOT NULL DEFAULT 0,
    "completed" BOOLEAN NOT NULL DEFAULT false,
    "unlockedAt" TIMESTAMP(3),
    "equipped" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "UserAchievement_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "UserTravelDNA_userId_idx" ON "UserTravelDNA"("userId");

-- CreateIndex
CREATE INDEX "UserTravelDNA_type_idx" ON "UserTravelDNA"("type");

-- CreateIndex
CREATE UNIQUE INDEX "UserTravelDNA_userId_type_key" ON "UserTravelDNA"("userId", "type");

-- CreateIndex
CREATE UNIQUE INDEX "Achievement_code_key" ON "Achievement"("code");

-- CreateIndex
CREATE UNIQUE INDEX "AchievementLevel_achievementId_level_key" ON "AchievementLevel"("achievementId", "level");

-- CreateIndex
CREATE INDEX "UserAchievement_userId_idx" ON "UserAchievement"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "UserAchievement_userId_achievementId_key" ON "UserAchievement"("userId", "achievementId");

-- CreateIndex
CREATE INDEX "TripTimelineEvent_memberId_idx" ON "TripTimelineEvent"("memberId");

-- AddForeignKey
ALTER TABLE "UserTravelDNA" ADD CONSTRAINT "UserTravelDNA_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripMessage" ADD CONSTRAINT "TripMessage_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "trip_members"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripTimelineEvent" ADD CONSTRAINT "TripTimelineEvent_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "trip_members"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AchievementLevel" ADD CONSTRAINT "AchievementLevel_achievementId_fkey" FOREIGN KEY ("achievementId") REFERENCES "Achievement"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAchievement" ADD CONSTRAINT "UserAchievement_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAchievement" ADD CONSTRAINT "UserAchievement_achievementId_fkey" FOREIGN KEY ("achievementId") REFERENCES "Achievement"("id") ON DELETE CASCADE ON UPDATE CASCADE;
