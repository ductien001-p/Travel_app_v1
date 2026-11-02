/*
  Warnings:

  - The values [TRAVELLER] on the enum `RANK` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "RANK_new" AS ENUM ('BEGINNER', 'EXPLORER', 'ADVENTURER', 'TRAVELER', 'LEGEND');
ALTER TABLE "public"."UserRanking" ALTER COLUMN "rank" DROP DEFAULT;
ALTER TABLE "UserRanking" ALTER COLUMN "rank" TYPE "RANK_new" USING ("rank"::text::"RANK_new");
ALTER TYPE "RANK" RENAME TO "RANK_old";
ALTER TYPE "RANK_new" RENAME TO "RANK";
DROP TYPE "public"."RANK_old";
ALTER TABLE "UserRanking" ALTER COLUMN "rank" SET DEFAULT 'BEGINNER';
COMMIT;
