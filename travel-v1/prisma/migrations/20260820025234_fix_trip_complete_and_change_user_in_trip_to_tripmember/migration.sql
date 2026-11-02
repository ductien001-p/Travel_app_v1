/*
  Warnings:

  - You are about to drop the column `icon` on the `interest` table. All the data in the column will be lost.
  - You are about to drop the `TripHistory` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[activityId,memberId]` on the table `TripCheckin` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[tripId,memberId]` on the table `TripCompletion` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `memberId` to the `TripCheckin` table without a default value. This is not possible if the table is not empty.
  - Added the required column `memberId` to the `TripCompletion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `currency` to the `TripExpense` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "EXPENSE_CATEGORY" AS ENUM ('ACCOMMODATION', 'FOOD', 'TRANSPORT', 'ACTIVITY', 'SHOPPING', 'OTHER');

-- DropForeignKey
ALTER TABLE "TripCheckin" DROP CONSTRAINT "TripCheckin_userId_fkey";

-- DropForeignKey
ALTER TABLE "TripCompletion" DROP CONSTRAINT "TripCompletion_userId_fkey";

-- DropForeignKey
ALTER TABLE "TripExpense" DROP CONSTRAINT "TripExpense_payerId_fkey";

-- DropForeignKey
ALTER TABLE "TripHistory" DROP CONSTRAINT "TripHistory_tripId_fkey";

-- DropForeignKey
ALTER TABLE "TripHistory" DROP CONSTRAINT "TripHistory_userId_fkey";

-- DropIndex
DROP INDEX "TripCheckin_activityId_userId_key";

-- DropIndex
DROP INDEX "TripCheckin_tripId_userId_createdAt_idx";

-- DropIndex
DROP INDEX "TripCheckin_userId_idx";

-- DropIndex
DROP INDEX "TripCompletion_tripId_userId_key";

-- DropIndex
DROP INDEX "TripCompletion_userId_idx";

-- AlterTable
ALTER TABLE "TripCheckin" ADD COLUMN     "memberId" TEXT NOT NULL,
ALTER COLUMN "userId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "TripCompletion" ADD COLUMN     "memberId" TEXT NOT NULL,
ALTER COLUMN "userId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "TripExpense" ADD COLUMN     "currency" "EXPENSE_CATEGORY" NOT NULL,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "userId" TEXT;

-- AlterTable
ALTER TABLE "interest" DROP COLUMN "icon";

-- DropTable
DROP TABLE "TripHistory";

-- CreateIndex
CREATE INDEX "TripCheckin_memberId_idx" ON "TripCheckin"("memberId");

-- CreateIndex
CREATE INDEX "TripCheckin_tripId_memberId_createdAt_idx" ON "TripCheckin"("tripId", "memberId", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "TripCheckin_activityId_memberId_key" ON "TripCheckin"("activityId", "memberId");

-- CreateIndex
CREATE INDEX "TripCompletion_memberId_idx" ON "TripCompletion"("memberId");

-- CreateIndex
CREATE UNIQUE INDEX "TripCompletion_tripId_memberId_key" ON "TripCompletion"("tripId", "memberId");

-- AddForeignKey
ALTER TABLE "TripCheckin" ADD CONSTRAINT "TripCheckin_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "trip_members"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripCheckin" ADD CONSTRAINT "TripCheckin_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripCompletion" ADD CONSTRAINT "TripCompletion_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "trip_members"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripCompletion" ADD CONSTRAINT "TripCompletion_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripExpense" ADD CONSTRAINT "TripExpense_payerId_fkey" FOREIGN KEY ("payerId") REFERENCES "trip_members"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripExpense" ADD CONSTRAINT "TripExpense_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
