/*
  Warnings:

  - Made the column `startDate` on table `trips` required. This step will fail if there are existing NULL values in that column.
  - Made the column `endDate` on table `trips` required. This step will fail if there are existing NULL values in that column.
  - Made the column `maxMembers` on table `trips` required. This step will fail if there are existing NULL values in that column.
  - Made the column `inviteCode` on table `trips` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "trips" ALTER COLUMN "startDate" SET NOT NULL,
ALTER COLUMN "endDate" SET NOT NULL,
ALTER COLUMN "maxMembers" SET NOT NULL,
ALTER COLUMN "inviteCode" SET NOT NULL;
