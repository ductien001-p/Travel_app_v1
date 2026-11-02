/*
  Warnings:

  - The values [INDIVIDUAL] on the enum `EXPENSE_SPLIT_TYPE` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "EXPENSE_SPLIT_TYPE_new" AS ENUM ('EQUAL', 'CUSTOM');
ALTER TABLE "TripExpense" ALTER COLUMN "splitType" TYPE "EXPENSE_SPLIT_TYPE_new" USING ("splitType"::text::"EXPENSE_SPLIT_TYPE_new");
ALTER TYPE "EXPENSE_SPLIT_TYPE" RENAME TO "EXPENSE_SPLIT_TYPE_old";
ALTER TYPE "EXPENSE_SPLIT_TYPE_new" RENAME TO "EXPENSE_SPLIT_TYPE";
DROP TYPE "public"."EXPENSE_SPLIT_TYPE_old";
COMMIT;
