/*
  Warnings:

  - Made the column `type` on table `ItineraryActivity` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "ItineraryActivity" ALTER COLUMN "type" SET NOT NULL;
