/*
  Warnings:

  - The values [OPEN,NOTCOMPLETED] on the enum `TRIP_STATUS` will be removed. If these variants are still used in the database, this will fail.
  - A unique constraint covering the columns `[activityId,userId]` on the table `TripCheckin` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `activityId` to the `TripCheckin` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "TRIP_STATUS_new" AS ENUM ('UPCOMING', 'ONGOING', 'CANCELLED', 'COMPLETED', 'NOTCOM');
ALTER TABLE "public"."trips" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "trips" ALTER COLUMN "status" TYPE "TRIP_STATUS_new" USING ("status"::text::"TRIP_STATUS_new");
ALTER TYPE "TRIP_STATUS" RENAME TO "TRIP_STATUS_old";
ALTER TYPE "TRIP_STATUS_new" RENAME TO "TRIP_STATUS";
DROP TYPE "public"."TRIP_STATUS_old";
ALTER TABLE "trips" ALTER COLUMN "status" SET DEFAULT 'UPCOMING';
COMMIT;

-- AlterTable
ALTER TABLE "TripCheckin" ADD COLUMN     "activityId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "trips" ALTER COLUMN "status" SET DEFAULT 'UPCOMING';

-- CreateIndex
CREATE UNIQUE INDEX "TripCheckin_activityId_userId_key" ON "TripCheckin"("activityId", "userId");

-- AddForeignKey
ALTER TABLE "TripCheckin" ADD CONSTRAINT "TripCheckin_activityId_fkey" FOREIGN KEY ("activityId") REFERENCES "ItineraryActivity"("id") ON DELETE CASCADE ON UPDATE CASCADE;
