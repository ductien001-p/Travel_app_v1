-- User-owned place collections, public ratings, and snapshot copies.
CREATE TYPE "PlaceCollectionVisibility" AS ENUM ('PRIVATE', 'PUBLIC');

CREATE TABLE "PlaceCollection" (
    "id" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "title" VARCHAR(80) NOT NULL,
    "visibility" "PlaceCollectionVisibility" NOT NULL DEFAULT 'PRIVATE',
    "sourceCollectionId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PlaceCollection_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "PlaceCollectionItem" (
    "id" TEXT NOT NULL,
    "collectionId" TEXT NOT NULL,
    "placeId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PlaceCollectionItem_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "PlaceCollectionRating" (
    "id" TEXT NOT NULL,
    "collectionId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "rating" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PlaceCollectionRating_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "PlaceCollection_ownerId_sourceCollectionId_key" ON "PlaceCollection"("ownerId", "sourceCollectionId");

CREATE INDEX "PlaceCollection_ownerId_createdAt_idx" ON "PlaceCollection"("ownerId", "createdAt");

CREATE INDEX "PlaceCollection_visibility_sourceCollectionId_idx" ON "PlaceCollection"("visibility", "sourceCollectionId");

CREATE INDEX "PlaceCollection_sourceCollectionId_idx" ON "PlaceCollection"("sourceCollectionId");

CREATE UNIQUE INDEX "PlaceCollectionItem_collectionId_placeId_key" ON "PlaceCollectionItem"("collectionId", "placeId");

CREATE INDEX "PlaceCollectionItem_placeId_idx" ON "PlaceCollectionItem"("placeId");

CREATE INDEX "PlaceCollectionItem_collectionId_createdAt_idx" ON "PlaceCollectionItem"("collectionId", "createdAt");

CREATE UNIQUE INDEX "PlaceCollectionRating_collectionId_userId_key" ON "PlaceCollectionRating"("collectionId", "userId");

CREATE INDEX "PlaceCollectionRating_userId_idx" ON "PlaceCollectionRating"("userId");

ALTER TABLE "PlaceCollection" ADD CONSTRAINT "PlaceCollection_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "PlaceCollection" ADD CONSTRAINT "PlaceCollection_sourceCollectionId_fkey" FOREIGN KEY ("sourceCollectionId") REFERENCES "PlaceCollection"("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "PlaceCollectionItem" ADD CONSTRAINT "PlaceCollectionItem_collectionId_fkey" FOREIGN KEY ("collectionId") REFERENCES "PlaceCollection"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "PlaceCollectionItem" ADD CONSTRAINT "PlaceCollectionItem_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "PlaceCollectionRating" ADD CONSTRAINT "PlaceCollectionRating_collectionId_fkey" FOREIGN KEY ("collectionId") REFERENCES "PlaceCollection"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "PlaceCollectionRating" ADD CONSTRAINT "PlaceCollectionRating_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "PlaceCollectionRating" ADD CONSTRAINT "PlaceCollectionRating_rating_check" CHECK ("rating" >= 1 AND "rating" <= 5);
