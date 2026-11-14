-- Trip memory photos keep their own likes. SocialPostLike stays on posts.
ALTER TABLE "TripMedia" ADD COLUMN "likeCount" INTEGER NOT NULL DEFAULT 0;

CREATE TABLE "TripMediaLike" (
    "id" TEXT NOT NULL,
    "tripMediaId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TripMediaLike_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "TripMediaLike_tripMediaId_userId_key" ON "TripMediaLike"("tripMediaId", "userId");

CREATE INDEX "TripMediaLike_userId_idx" ON "TripMediaLike"("userId");

ALTER TABLE "TripMediaLike" ADD CONSTRAINT "TripMediaLike_tripMediaId_fkey" FOREIGN KEY ("tripMediaId") REFERENCES "TripMedia"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "TripMediaLike" ADD CONSTRAINT "TripMediaLike_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
