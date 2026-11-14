-- CreateEnum
CREATE TYPE "TRIP_MISSION_GROUP" AS ENUM ('EXPLORATION', 'FOOD', 'CULTURE', 'ADVENTURE', 'NATURE', 'SOCIAL', 'EXPERIENCE', 'RESPONSIBLE');

-- CreateEnum
CREATE TYPE "TRIP_MISSION_VERIFY" AS ENUM ('CHECKIN_COUNT', 'CHECKIN_NEW_CITY', 'CHECKIN_PLACE_CATEGORY', 'MEMORY_COUNT');

-- CreateEnum
CREATE TYPE "TRIP_MISSION_SCOPE" AS ENUM ('PERSONAL', 'GROUP');

-- CreateEnum
CREATE TYPE "TRAVEL_TIER_CODE" AS ENUM ('ROOKIE', 'EXPLORER', 'TRAVELER', 'ADVENTURER', 'LEGEND');

-- CreateEnum
CREATE TYPE "ACHIEVEMENT_RARITY" AS ENUM ('BRONZE', 'SILVER', 'GOLD');

-- AlterTable TripCompletion
ALTER TABLE "TripCompletion" ADD COLUMN "basePoints" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "TripCompletion" ADD COLUMN "missionPoints" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "TripCompletion" ADD COLUMN "multiplierUsed" DECIMAL(3,2) NOT NULL DEFAULT 1.00;
ALTER TABLE "TripCompletion" ADD COLUMN "breakdownJson" JSONB;

-- CreateTable
CREATE TABLE "TripMissionTemplate" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "group" "TRIP_MISSION_GROUP" NOT NULL,
    "title" TEXT NOT NULL,
    "subtitle" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "verifyType" "TRIP_MISSION_VERIFY" NOT NULL,
    "verifyPayload" JSONB NOT NULL DEFAULT '{}',
    "pointsReward" INTEGER NOT NULL,
    "targetCountDefault" INTEGER NOT NULL DEFAULT 1,
    "scope" "TRIP_MISSION_SCOPE" NOT NULL DEFAULT 'PERSONAL',
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TripMissionTemplate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TripMissionSeedRule" (
    "id" TEXT NOT NULL,
    "templateId" TEXT NOT NULL,
    "placeCategories" "PLACE_CATEGORY"[] DEFAULT ARRAY[]::"PLACE_CATEGORY"[],
    "requireNewCity" BOOLEAN NOT NULL DEFAULT false,
    "priority" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TripMissionSeedRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TripMissionInstance" (
    "id" TEXT NOT NULL,
    "tripId" TEXT NOT NULL,
    "templateId" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "group" "TRIP_MISSION_GROUP" NOT NULL,
    "title" TEXT NOT NULL,
    "subtitle" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "verifyType" "TRIP_MISSION_VERIFY" NOT NULL,
    "verifyPayload" JSONB NOT NULL DEFAULT '{}',
    "targetCount" INTEGER NOT NULL,
    "pointsReward" INTEGER NOT NULL,
    "scope" "TRIP_MISSION_SCOPE" NOT NULL DEFAULT 'PERSONAL',
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TripMissionInstance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TripMissionProgress" (
    "id" TEXT NOT NULL,
    "instanceId" TEXT NOT NULL,
    "memberId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "currentCount" INTEGER NOT NULL DEFAULT 0,
    "completedAt" TIMESTAMP(3),
    "claimedInCompletion" BOOLEAN NOT NULL DEFAULT false,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TripMissionProgress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserTravelTier" (
    "userId" TEXT NOT NULL,
    "tierCode" "TRAVEL_TIER_CODE" NOT NULL DEFAULT 'ROOKIE',
    "multiplier" DECIMAL(3,2) NOT NULL DEFAULT 1.00,
    "tripsCompleted" INTEGER NOT NULL DEFAULT 0,
    "distinctCities" INTEGER NOT NULL DEFAULT 0,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserTravelTier_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "AchievementDefinition" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "rarity" "ACHIEVEMENT_RARITY" NOT NULL DEFAULT 'BRONZE',
    "metric" TEXT NOT NULL,
    "targetCount" INTEGER NOT NULL,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AchievementDefinition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserAchievementProgress" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "achievementId" TEXT NOT NULL,
    "currentCount" INTEGER NOT NULL DEFAULT 0,
    "unlockedAt" TIMESTAMP(3),
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserAchievementProgress_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "TripMissionTemplate_code_key" ON "TripMissionTemplate"("code");

-- CreateIndex
CREATE INDEX "TripMissionSeedRule_templateId_idx" ON "TripMissionSeedRule"("templateId");

-- CreateIndex
CREATE INDEX "TripMissionSeedRule_priority_idx" ON "TripMissionSeedRule"("priority");

-- CreateIndex
CREATE INDEX "TripMissionInstance_tripId_idx" ON "TripMissionInstance"("tripId");

-- CreateIndex
CREATE INDEX "TripMissionInstance_templateId_idx" ON "TripMissionInstance"("templateId");

-- CreateIndex
CREATE UNIQUE INDEX "TripMissionInstance_tripId_code_key" ON "TripMissionInstance"("tripId", "code");

-- CreateIndex
CREATE INDEX "TripMissionProgress_userId_idx" ON "TripMissionProgress"("userId");

-- CreateIndex
CREATE INDEX "TripMissionProgress_memberId_idx" ON "TripMissionProgress"("memberId");

-- CreateIndex
CREATE INDEX "TripMissionProgress_instanceId_idx" ON "TripMissionProgress"("instanceId");

-- CreateIndex
CREATE UNIQUE INDEX "TripMissionProgress_instanceId_memberId_key" ON "TripMissionProgress"("instanceId", "memberId");

-- CreateIndex
CREATE UNIQUE INDEX "AchievementDefinition_code_key" ON "AchievementDefinition"("code");

-- CreateIndex
CREATE INDEX "UserAchievementProgress_userId_idx" ON "UserAchievementProgress"("userId");

-- CreateIndex
CREATE INDEX "UserAchievementProgress_achievementId_idx" ON "UserAchievementProgress"("achievementId");

-- CreateIndex
CREATE UNIQUE INDEX "UserAchievementProgress_userId_achievementId_key" ON "UserAchievementProgress"("userId", "achievementId");

-- AddForeignKey
ALTER TABLE "TripMissionSeedRule" ADD CONSTRAINT "TripMissionSeedRule_templateId_fkey" FOREIGN KEY ("templateId") REFERENCES "TripMissionTemplate"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripMissionInstance" ADD CONSTRAINT "TripMissionInstance_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "trips"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripMissionInstance" ADD CONSTRAINT "TripMissionInstance_templateId_fkey" FOREIGN KEY ("templateId") REFERENCES "TripMissionTemplate"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripMissionProgress" ADD CONSTRAINT "TripMissionProgress_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES "TripMissionInstance"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripMissionProgress" ADD CONSTRAINT "TripMissionProgress_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "trip_members"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripMissionProgress" ADD CONSTRAINT "TripMissionProgress_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserTravelTier" ADD CONSTRAINT "UserTravelTier_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAchievementProgress" ADD CONSTRAINT "UserAchievementProgress_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAchievementProgress" ADD CONSTRAINT "UserAchievementProgress_achievementId_fkey" FOREIGN KEY ("achievementId") REFERENCES "AchievementDefinition"("id") ON DELETE CASCADE ON UPDATE CASCADE;
