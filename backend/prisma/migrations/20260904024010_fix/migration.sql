/*
  Warnings:

  - You are about to drop the `Achievement` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `AchievementLevel` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `UserAchievement` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterEnum
ALTER TYPE "RANK" ADD VALUE 'TRAVELLER';

-- DropForeignKey
ALTER TABLE "AchievementLevel" DROP CONSTRAINT "AchievementLevel_achievementId_fkey";

-- DropForeignKey
ALTER TABLE "UserAchievement" DROP CONSTRAINT "UserAchievement_achievementId_fkey";

-- DropForeignKey
ALTER TABLE "UserAchievement" DROP CONSTRAINT "UserAchievement_userId_fkey";

-- DropTable
DROP TABLE "Achievement";

-- DropTable
DROP TABLE "AchievementLevel";

-- DropTable
DROP TABLE "UserAchievement";

-- DropEnum
DROP TYPE "AchievementCategory";
