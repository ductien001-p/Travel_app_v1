/*
  Warnings:

  - Made the column `startDate` on table `TripDestination` required. This step will fail if there are existing NULL values in that column.
  - Made the column `endDate` on table `TripDestination` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "TripDestination" ALTER COLUMN "startDate" SET NOT NULL,
ALTER COLUMN "endDate" SET NOT NULL;
