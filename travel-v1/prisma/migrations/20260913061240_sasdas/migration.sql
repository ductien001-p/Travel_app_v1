/*
  Warnings:

  - You are about to drop the column `fcmToken` on the `User` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "TripCompletion_tripId_memberId_key";

-- DropIndex
DROP INDEX "TripMedia_tripId_mediaId_key";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "fcmToken";
