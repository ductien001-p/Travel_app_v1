/*
  Warnings:

  - The values [NOTCOM] on the enum `TRIP_STATUS` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "TRIP_STATUS_new" AS ENUM ('UPCOMING', 'ONGOING', 'CANCELLED', 'COMPLETED', 'NOTCOMPLETED');
ALTER TABLE "public"."trips" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "trips" ALTER COLUMN "status" TYPE "TRIP_STATUS_new" USING ("status"::text::"TRIP_STATUS_new");
ALTER TYPE "TRIP_STATUS" RENAME TO "TRIP_STATUS_old";
ALTER TYPE "TRIP_STATUS_new" RENAME TO "TRIP_STATUS";
DROP TYPE "public"."TRIP_STATUS_old";
ALTER TABLE "trips" ALTER COLUMN "status" SET DEFAULT 'UPCOMING';
COMMIT;
