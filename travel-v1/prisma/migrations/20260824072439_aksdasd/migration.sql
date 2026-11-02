/*
  Warnings:

  - The `type` column on the `ItineraryActivity` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "ACTIVITY_TYPE" AS ENUM ('FOOD', 'PHOTOGRAPHY', 'ADVENTURE', 'SIGHTSEEING', 'EXPERIENCE');

-- AlterTable
ALTER TABLE "ItineraryActivity" DROP COLUMN "type",
ADD COLUMN     "type" "ACTIVITY_TYPE";

-- DropEnum
DROP TYPE "ActivityType";
