-- CreateEnum
CREATE TYPE "SocialPostTopic" AS ENUM ('HIDDEN_EATS', 'PHOTO_SPOTS', 'ITINERARY_2N1D', 'FIND_BUDDY');

-- AlterTable
ALTER TABLE "Post" ADD COLUMN     "placeDetail" VARCHAR(200),
ADD COLUMN     "savesCount" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "tipBody" VARCHAR(500),
ADD COLUMN     "tipTitle" VARCHAR(120),
ADD COLUMN     "topic" "SocialPostTopic";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "isVerified" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "profileBadge" TEXT;

-- CreateTable
CREATE TABLE "SocialPostSave" (
    "id" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SocialPostSave_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SocialStory" (
    "id" TEXT NOT NULL,
    "authorId" TEXT NOT NULL,
    "mediaId" TEXT NOT NULL,
    "label" VARCHAR(80) NOT NULL,
    "isLive" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3),

    CONSTRAINT "SocialStory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SocialChallenge" (
    "id" TEXT NOT NULL,
    "eyebrow" VARCHAR(80) NOT NULL,
    "title" VARCHAR(200) NOT NULL,
    "rewardLabel" VARCHAR(80) NOT NULL,
    "badgeLabel" VARCHAR(160) NOT NULL,
    "targetCount" INTEGER NOT NULL DEFAULT 3,
    "endsAt" TIMESTAMP(3) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SocialChallenge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SocialChallengeProgress" (
    "id" TEXT NOT NULL,
    "challengeId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "progressCount" INTEGER NOT NULL DEFAULT 0,
    "joinedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SocialChallengeProgress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserTravelStreak" (
    "userId" TEXT NOT NULL,
    "currentDays" INTEGER NOT NULL DEFAULT 0,
    "lastActiveDate" DATE NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserTravelStreak_pkey" PRIMARY KEY ("userId")
);

-- CreateIndex
CREATE INDEX "SocialPostSave_userId_createdAt_idx" ON "SocialPostSave"("userId", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "SocialPostSave_postId_userId_key" ON "SocialPostSave"("postId", "userId");

-- CreateIndex
CREATE INDEX "SocialStory_authorId_createdAt_idx" ON "SocialStory"("authorId", "createdAt");

-- CreateIndex
CREATE INDEX "SocialStory_createdAt_idx" ON "SocialStory"("createdAt");

-- CreateIndex
CREATE INDEX "SocialChallenge_isActive_endsAt_idx" ON "SocialChallenge"("isActive", "endsAt");

-- CreateIndex
CREATE INDEX "SocialChallengeProgress_userId_idx" ON "SocialChallengeProgress"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "SocialChallengeProgress_challengeId_userId_key" ON "SocialChallengeProgress"("challengeId", "userId");

-- CreateIndex
CREATE INDEX "Post_topic_createdAt_idx" ON "Post"("topic", "createdAt");

-- AddForeignKey
ALTER TABLE "SocialPostSave" ADD CONSTRAINT "SocialPostSave_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialPostSave" ADD CONSTRAINT "SocialPostSave_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialStory" ADD CONSTRAINT "SocialStory_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialStory" ADD CONSTRAINT "SocialStory_mediaId_fkey" FOREIGN KEY ("mediaId") REFERENCES "UploadedMedia"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialChallengeProgress" ADD CONSTRAINT "SocialChallengeProgress_challengeId_fkey" FOREIGN KEY ("challengeId") REFERENCES "SocialChallenge"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SocialChallengeProgress" ADD CONSTRAINT "SocialChallengeProgress_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserTravelStreak" ADD CONSTRAINT "UserTravelStreak_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
