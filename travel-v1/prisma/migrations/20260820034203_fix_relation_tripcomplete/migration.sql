/*
  Warnings:

  - A unique constraint covering the columns `[memberId]` on the table `TripCompletion` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "TripCompletion_memberId_key" ON "TripCompletion"("memberId");
