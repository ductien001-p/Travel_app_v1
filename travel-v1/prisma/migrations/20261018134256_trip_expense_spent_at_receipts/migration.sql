-- AlterTable
ALTER TABLE "TripExpense" ADD COLUMN     "locationNote" VARCHAR(200),
ADD COLUMN     "spentAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- CreateTable
CREATE TABLE "TripExpenseReceipt" (
    "id" TEXT NOT NULL,
    "expenseId" TEXT NOT NULL,
    "mediaId" TEXT NOT NULL,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TripExpenseReceipt_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "TripExpenseReceipt_expenseId_idx" ON "TripExpenseReceipt"("expenseId");

-- CreateIndex
CREATE INDEX "TripExpenseReceipt_mediaId_idx" ON "TripExpenseReceipt"("mediaId");

-- CreateIndex
CREATE UNIQUE INDEX "TripExpenseReceipt_expenseId_mediaId_key" ON "TripExpenseReceipt"("expenseId", "mediaId");

-- CreateIndex
CREATE INDEX "TripExpense_tripId_spentAt_idx" ON "TripExpense"("tripId", "spentAt");

-- AddForeignKey
ALTER TABLE "TripExpenseReceipt" ADD CONSTRAINT "TripExpenseReceipt_expenseId_fkey" FOREIGN KEY ("expenseId") REFERENCES "TripExpense"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripExpenseReceipt" ADD CONSTRAINT "TripExpenseReceipt_mediaId_fkey" FOREIGN KEY ("mediaId") REFERENCES "UploadedMedia"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
