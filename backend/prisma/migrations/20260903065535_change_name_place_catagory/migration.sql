/*
  Warnings:

  - Changed the type of `category` on the `Place` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "PLACE_CATEGORY" AS ENUM ('FOOD', 'CAFE', 'HOTEL', 'RESORT', 'HOSTEL', 'HOMESTAY', 'VILLA', 'MOUNTAIN', 'BEACH', 'CAVE', 'WATERFALL', 'PARK', 'LAKE', 'CAMPING', 'MUSEUM', 'TEMPLES', 'CHURCH', 'HISTORICAL_SITE', 'MONUMENT', 'PALACE', 'CASTLE', 'OLD_TOWN', 'ZOO', 'WATER_PARK', 'CINEMA', 'THEATER', 'NIGHT_MARKET', 'SHOPPING_MALL', 'MARKET', 'ZIPLINE', 'WALKING_STREET', 'BRIDGE', 'HARBOR');

-- AlterTable
ALTER TABLE "Place" DROP COLUMN "category",
ADD COLUMN     "category" "PLACE_CATEGORY" NOT NULL;

-- DropEnum
DROP TYPE "PlaceCategory";

-- CreateIndex
CREATE INDEX "Place_category_idx" ON "Place"("category");
