/*
  Warnings:

  - A unique constraint covering the columns `[userId,installationId]` on the table `DeviceToken` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `installationId` to the `DeviceToken` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "DeviceToken" ADD COLUMN     "installationId" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "DeviceToken_userId_installationId_key" ON "DeviceToken"("userId", "installationId");
