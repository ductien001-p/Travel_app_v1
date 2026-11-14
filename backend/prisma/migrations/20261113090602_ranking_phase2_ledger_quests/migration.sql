-- CreateEnum
CREATE TYPE "RANKING_POINT_REASON" AS ENUM ('TRIP_COMPLETION', 'QUEST_CLAIM');

-- CreateEnum
CREATE TYPE "RANKING_QUEST_ACTION" AS ENUM ('START', 'CONTINUE', 'WRITE');

-- CreateEnum
CREATE TYPE "RANKING_QUEST_TONE" AS ENUM ('PRIMARY', 'SECONDARY', 'TERTIARY');

-- CreateTable
CREATE TABLE "RankingPointLedger" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "points" INTEGER NOT NULL,
    "reason" "RANKING_POINT_REASON" NOT NULL,
    "sourceType" TEXT,
    "sourceId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RankingPointLedger_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RankingSeason" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "label" TEXT NOT NULL,
    "startsAt" TIMESTAMP(3) NOT NULL,
    "endsAt" TIMESTAMP(3) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RankingSeason_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RankingQuestDefinition" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "subtitle" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "pointsReward" INTEGER NOT NULL,
    "action" "RANKING_QUEST_ACTION" NOT NULL,
    "tone" "RANKING_QUEST_TONE" NOT NULL DEFAULT 'PRIMARY',
    "targetCount" INTEGER NOT NULL DEFAULT 1,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RankingQuestDefinition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RankingQuestClaim" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "questId" TEXT NOT NULL,
    "claimedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pointsAwarded" INTEGER NOT NULL,
    "ledgerId" TEXT NOT NULL,

    CONSTRAINT "RankingQuestClaim_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "RankingPointLedger_createdAt_idx" ON "RankingPointLedger"("createdAt");

-- CreateIndex
CREATE INDEX "RankingPointLedger_userId_createdAt_idx" ON "RankingPointLedger"("userId", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "RankingPointLedger_reason_sourceType_sourceId_key" ON "RankingPointLedger"("reason", "sourceType", "sourceId");

-- CreateIndex
CREATE UNIQUE INDEX "RankingSeason_code_key" ON "RankingSeason"("code");

-- CreateIndex
CREATE INDEX "RankingSeason_isActive_startsAt_endsAt_idx" ON "RankingSeason"("isActive", "startsAt", "endsAt");

-- CreateIndex
CREATE UNIQUE INDEX "RankingQuestDefinition_code_key" ON "RankingQuestDefinition"("code");

-- CreateIndex
CREATE UNIQUE INDEX "RankingQuestClaim_ledgerId_key" ON "RankingQuestClaim"("ledgerId");

-- CreateIndex
CREATE INDEX "RankingQuestClaim_userId_idx" ON "RankingQuestClaim"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "RankingQuestClaim_userId_questId_key" ON "RankingQuestClaim"("userId", "questId");

-- AddForeignKey
ALTER TABLE "RankingPointLedger" ADD CONSTRAINT "RankingPointLedger_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RankingQuestClaim" ADD CONSTRAINT "RankingQuestClaim_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RankingQuestClaim" ADD CONSTRAINT "RankingQuestClaim_questId_fkey" FOREIGN KEY ("questId") REFERENCES "RankingQuestDefinition"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RankingQuestClaim" ADD CONSTRAINT "RankingQuestClaim_ledgerId_fkey" FOREIGN KEY ("ledgerId") REFERENCES "RankingPointLedger"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
