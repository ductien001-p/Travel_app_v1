/*
  Warnings:

  - The values [CUSTOMER] on the enum `USER_ROLE` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `deleteAt` on the `User` table. All the data in the column will be lost.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "USER_ROLE_new" AS ENUM ('USER', 'ADMIN', 'HOST');
ALTER TABLE "public"."User" ALTER COLUMN "role" DROP DEFAULT;
ALTER TABLE "User" ALTER COLUMN "role" TYPE "USER_ROLE_new" USING ("role"::text::"USER_ROLE_new");
ALTER TYPE "USER_ROLE" RENAME TO "USER_ROLE_old";
ALTER TYPE "USER_ROLE_new" RENAME TO "USER_ROLE";
DROP TYPE "public"."USER_ROLE_old";
ALTER TABLE "User" ALTER COLUMN "role" SET DEFAULT 'USER';
COMMIT;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "deleteAt",
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ALTER COLUMN "role" SET DEFAULT 'USER',
ALTER COLUMN "status" SET DEFAULT 'INACTIVE';
