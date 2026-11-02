/*
  Warnings:

  - You are about to drop the column `ranking` on the `UserRanking` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "UserRanking" DROP COLUMN "ranking";

-- CreateTable
CREATE TABLE "DailyLeaderboard" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "points" INTEGER NOT NULL,
    "ranking" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DailyLeaderboard_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "DailyLeaderboard_date_ranking_idx" ON "DailyLeaderboard"("date", "ranking");

-- CreateIndex
CREATE UNIQUE INDEX "DailyLeaderboard_userId_date_key" ON "DailyLeaderboard"("userId", "date");

-- AddForeignKey
ALTER TABLE "DailyLeaderboard" ADD CONSTRAINT "DailyLeaderboard_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
