-- DropIndex
DROP INDEX IF EXISTS "RankingPointLedger_reason_sourceType_sourceId_key";

-- CreateIndex
CREATE UNIQUE INDEX "RankingPointLedger_userId_reason_sourceType_sourceId_key" ON "RankingPointLedger"("userId", "reason", "sourceType", "sourceId");
