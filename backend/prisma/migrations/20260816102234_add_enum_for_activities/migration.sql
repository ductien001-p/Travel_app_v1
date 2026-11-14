/*
  Warnings:

  - The `type` column on the `ItineraryActivity` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "ActivityType" AS ENUM ('FOOD', 'SIGHTSEEING', 'TRANSPORT', 'ACCOMMODATION', 'ACTIVITY');

-- AlterTable
ALTER TABLE "ItineraryActivity" DROP COLUMN "type",
ADD COLUMN     "type" "ActivityType";
