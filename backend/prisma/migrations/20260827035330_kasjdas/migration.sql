/*
  Warnings:

  - The values [HIKING,TREKKING,SURFING,CLIMBING] on the enum `PlaceCategory` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the `SocialPostPlace` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `address` on table `Place` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterEnum
BEGIN;
CREATE EXTENSION IF NOT EXISTS vector;
CREATE TYPE "PlaceCategory_new" AS ENUM ('CAFE', 'RESTAURANT', 'FOOD', 'HOTEL', 'RESORT', 'HOSTEL', 'HOMESTAY', 'VILLA', 'CAMPING', 'MOUNTAIN', 'BEACH', 'CAVE', 'WATERFALL', 'PARK', 'LAKE', 'MUSEUM', 'TEMPLES', 'CHURCH', 'HISTORICAL_SITE', 'MONUMENT', 'PALACE', 'CASTLE', 'OLD_TOWN', 'ZOO', 'WATER_PARK', 'CINEMA', 'THEATER', 'NIGHT_MARKET', 'SHOPPING_MALL', 'MARKET', 'ZIPLINE', 'CAMPING_SITE', 'BRIDGE', 'HARBOR', 'WALKING_STREET');
ALTER TABLE "Place" ALTER COLUMN "category" TYPE "PlaceCategory_new" USING ("category"::text::"PlaceCategory_new");
ALTER TYPE "PlaceCategory" RENAME TO "PlaceCategory_old";
ALTER TYPE "PlaceCategory_new" RENAME TO "PlaceCategory";
DROP TYPE "public"."PlaceCategory_old";
COMMIT;

-- AlterEnum
ALTER TYPE "PlaceStatus" ADD VALUE 'DELETED';

-- DropForeignKey
ALTER TABLE "SocialPostPlace" DROP CONSTRAINT "SocialPostPlace_placeId_fkey";

-- DropForeignKey
ALTER TABLE "SocialPostPlace" DROP CONSTRAINT "SocialPostPlace_postId_fkey";

-- AlterTable
ALTER TABLE "Place" ADD COLUMN     "embedding" vector(768),
ALTER COLUMN "address" SET NOT NULL,
ALTER COLUMN "status" SET DEFAULT 'PENDING';

-- DropTable
DROP TABLE "SocialPostPlace";


