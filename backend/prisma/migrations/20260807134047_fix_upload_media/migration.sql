/*
  Warnings:

  - You are about to drop the `PasswordResetToken` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SocialPlacePost` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SocialPostMedia` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "PasswordResetToken" DROP CONSTRAINT "PasswordResetToken_userId_fkey";

-- DropForeignKey
ALTER TABLE "SocialPlacePost" DROP CONSTRAINT "SocialPlacePost_authorId_fkey";

-- DropForeignKey
ALTER TABLE "SocialPlacePost" DROP CONSTRAINT "SocialPlacePost_placeId_fkey";

-- DropForeignKey
ALTER TABLE "SocialPostComment" DROP CONSTRAINT "SocialPostComment_postId_fkey";

-- DropForeignKey
ALTER TABLE "SocialPostLike" DROP CONSTRAINT "SocialPostLike_postId_fkey";

-- DropForeignKey
ALTER TABLE "SocialPostMedia" DROP CONSTRAINT "SocialPostMedia_postId_fkey";

-- DropIndex
DROP INDEX "RefreshToken_userId_key";

-- DropTable
DROP TABLE "PasswordResetToken";

-- DropTable
DROP TABLE "SocialPlacePost";

-- DropTable
DROP TABLE "SocialPostMedia";

-- DropEnum
DROP TYPE "SocialMediaType";

-- CreateTable
CREATE TABLE "TripMedia" (
    "id" TEXT NOT NULL,
    "tripId" TEXT NOT NULL,
    "mediaId" TEXT NOT NULL,
    "orderIndex" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TripMedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SocialPostPlace" (
    "id" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "placeId" TEXT NOT NULL,

    CONSTRAINT "SocialPostPlace_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Post" (
    "id" TEXT NOT NULL,
    "authorId" TEXT NOT NULL,
    "placeId" TEXT,
    "caption" VARCHAR(1000) NOT NULL,
    "visibility" "SocialPostVisibility" NOT NULL DEFAULT 'PUBLIC',
    "likesCount" INTEGER NOT NULL DEFAULT 0,
    "commentsCount" INTEGER NOT NULL DEFAULT 0,
    "sharesCount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "Post_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PostMedia" (
    "id" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "mediaId" TEXT NOT NULL,
    "orderIndex" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PostMedia_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "TripMedia_tripId_orderIndex_idx" ON "TripMedia"("tripId", "orderIndex");

-- CreateIndex
CREATE UNIQUE INDEX "SocialPostPlace_postId_placeId_key" ON "SocialPostPlace"("postId", "placeId");

-- CreateIndex
CREATE INDEX "Post_authorId_createdAt_idx" ON "Post"("authorId", "createdAt");

-- CreateIndex
CREATE INDEX "Post_placeId_createdAt_idx" ON "Post"("placeId", "createdAt");

-- CreateIndex
CREATE INDEX "Post_visibility_createdAt_idx" ON "Post"("visibility", "createdAt");

-- CreateIndex
CREATE INDEX "PostMedia_postId_orderIndex_idx" ON "PostMedia"("postId", "orderIndex");

-- AddForeignKey
ALTER TABLE "TripMedia" ADD CONSTRAINT "TripMedia_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "trips"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripMedia" ADD CONSTRAINT "TripMedia_mediaId_fkey" FOREIGN KEY ("mediaId") REFERENCES "UploadedMedia"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialPostPlace" ADD CONSTRAINT "SocialPostPlace_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialPostPlace" ADD CONSTRAINT "SocialPostPlace_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostMedia" ADD CONSTRAINT "PostMedia_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostMedia" ADD CONSTRAINT "PostMedia_mediaId_fkey" FOREIGN KEY ("mediaId") REFERENCES "UploadedMedia"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialPostLike" ADD CONSTRAINT "SocialPostLike_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialPostComment" ADD CONSTRAINT "SocialPostComment_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
