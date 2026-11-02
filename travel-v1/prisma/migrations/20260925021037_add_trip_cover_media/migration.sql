-- AlterTable
ALTER TABLE "trips" ADD COLUMN     "coverMediaId" TEXT;

-- CreateIndex
CREATE INDEX "trips_coverMediaId_idx" ON "trips"("coverMediaId");

-- AddForeignKey
ALTER TABLE "trips" ADD CONSTRAINT "trips_coverMediaId_fkey" FOREIGN KEY ("coverMediaId") REFERENCES "UploadedMedia"("id") ON DELETE SET NULL ON UPDATE CASCADE;
