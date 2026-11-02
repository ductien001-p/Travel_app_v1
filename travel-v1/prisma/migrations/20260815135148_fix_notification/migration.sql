/*
  Warnings:

  - You are about to drop the column `typeId` on the `Notification` table. All the data in the column will be lost.
  - You are about to drop the `notification_types` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `type` to the `Notification` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "NOTIFICATION_TYPE" AS ENUM ('TRIP_INVITATION', 'TRIP_INVITATION_ACCEPTED', 'TRIP_INVITATION_REJECTED', 'TRIP_MEMBER_JOINED', 'TRIP_MEMBER_LEFT', 'TRIP_MEMBER_REMOVED', 'TRIP_ROLE_CHANGED', 'TRIP_UPDATED', 'TRIP_STARTING_SOON', 'POST_LIKE', 'POST_COMMENT', 'POST_MENTION', 'FRIEND_REQUEST', 'FRIEND_REQUEST_ACCEPTED', 'SYSTEM_ANNOUNCEMENT');

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_typeId_fkey";

-- DropIndex
DROP INDEX "Notification_typeId_idx";

-- AlterTable
ALTER TABLE "Notification" DROP COLUMN "typeId",
ADD COLUMN     "type" "NOTIFICATION_TYPE" NOT NULL;

-- DropTable
DROP TABLE "notification_types";
