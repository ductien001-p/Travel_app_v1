/*
  Warnings:

  - The values [CHECKIN,PHOTO,NOTE] on the enum `TIMELINE_EVENT_TYPE` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the `TripPlace` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "TIMELINE_EVENT_TYPE_new" AS ENUM ('TRIP_CREATED', 'MEMBER_JOINED', 'MEMBER_LEFT', 'ACTIVITY_ADDED', 'ACTIVITY_UPDATED', 'ACTIVITY_REMOVED', 'EXPENSE_CREATED', 'EXPENSE_SETTLED', 'PHOTO_ADDED', 'SYSTEM');
ALTER TABLE "TripTimelineEvent" ALTER COLUMN "type" TYPE "TIMELINE_EVENT_TYPE_new" USING ("type"::text::"TIMELINE_EVENT_TYPE_new");
ALTER TYPE "TIMELINE_EVENT_TYPE" RENAME TO "TIMELINE_EVENT_TYPE_old";
ALTER TYPE "TIMELINE_EVENT_TYPE_new" RENAME TO "TIMELINE_EVENT_TYPE";
DROP TYPE "public"."TIMELINE_EVENT_TYPE_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "TripPlace" DROP CONSTRAINT "TripPlace_placeId_fkey";

-- DropForeignKey
ALTER TABLE "TripPlace" DROP CONSTRAINT "TripPlace_tripDestinationId_fkey";

-- DropForeignKey
ALTER TABLE "TripPlace" DROP CONSTRAINT "TripPlace_tripId_fkey";

-- DropTable
DROP TABLE "TripPlace";
