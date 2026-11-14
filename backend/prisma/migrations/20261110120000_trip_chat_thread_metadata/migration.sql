-- AlterEnum
ALTER TYPE "TRIP_MESSAGE_TYPE" ADD VALUE 'EXPENSE';

-- AlterTable
ALTER TABLE "TripMessage" ADD COLUMN "metadata" JSONB;

-- CreateTable
CREATE TABLE "trip_message_reactions" (
    "id" TEXT NOT NULL,
    "messageId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "emoji" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "trip_message_reactions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "trip_message_reactions_messageId_idx" ON "trip_message_reactions"("messageId");

-- CreateIndex
CREATE INDEX "trip_message_reactions_userId_idx" ON "trip_message_reactions"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "trip_message_reactions_messageId_userId_emoji_key" ON "trip_message_reactions"("messageId", "userId", "emoji");

-- AddForeignKey
ALTER TABLE "trip_message_reactions" ADD CONSTRAINT "trip_message_reactions_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES "TripMessage"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trip_message_reactions" ADD CONSTRAINT "trip_message_reactions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
