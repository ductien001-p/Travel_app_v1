/*
  Warnings:

  - You are about to drop the column `postCount` on the `Place` table. All the data in the column will be lost.
  - You are about to drop the column `reviewCount` on the `Place` table. All the data in the column will be lost.
  - You are about to drop the column `saveCount` on the `Place` table. All the data in the column will be lost.
  - You are about to drop the column `visitCount` on the `Place` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[postId,mediaId]` on the table `PostMedia` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Place" DROP COLUMN "postCount",
DROP COLUMN "reviewCount",
DROP COLUMN "saveCount",
DROP COLUMN "visitCount";

-- CreateTable
CREATE TABLE "PlaceVisit" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "placeId" TEXT NOT NULL,
    "visitedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PlaceVisit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SocialPostShare" (
    "id" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SocialPostShare_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "PlaceVisit_placeId_idx" ON "PlaceVisit"("placeId");

-- CreateIndex
CREATE INDEX "PlaceVisit_userId_idx" ON "PlaceVisit"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "PlaceVisit_userId_placeId_key" ON "PlaceVisit"("userId", "placeId");

-- CreateIndex
CREATE INDEX "SocialPostShare_userId_createdAt_idx" ON "SocialPostShare"("userId", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "SocialPostShare_postId_userId_key" ON "SocialPostShare"("postId", "userId");

-- CreateIndex
CREATE INDEX "Post_createdAt_idx" ON "Post"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "PostMedia_postId_mediaId_key" ON "PostMedia"("postId", "mediaId");

-- AddForeignKey
ALTER TABLE "PlaceVisit" ADD CONSTRAINT "PlaceVisit_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlaceVisit" ADD CONSTRAINT "PlaceVisit_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialPostShare" ADD CONSTRAINT "SocialPostShare_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialPostShare" ADD CONSTRAINT "SocialPostShare_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
