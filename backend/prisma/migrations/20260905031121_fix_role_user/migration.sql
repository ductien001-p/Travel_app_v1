/*
  Warnings:

  - You are about to drop the column `externalId` on the `Place` table. All the data in the column will be lost.
  - You are about to drop the column `source` on the `Place` table. All the data in the column will be lost.
  - Changed the column `role` on the `User` table from a scalar field to a list field. If there are non-null values in that column, this step will fail.

*/
-- DropIndex
DROP INDEX "Place_source_externalId_key";

-- AlterTable
ALTER TABLE "Place" DROP COLUMN "externalId",
DROP COLUMN "source";

ALTER TABLE "User"
ADD COLUMN "roles" "USER_ROLE"[] NOT NULL DEFAULT ARRAY[]::"USER_ROLE"[];

UPDATE "User"
SET "roles" = ARRAY["role"]::"USER_ROLE"[];

ALTER TABLE "User"
DROP COLUMN "role";
