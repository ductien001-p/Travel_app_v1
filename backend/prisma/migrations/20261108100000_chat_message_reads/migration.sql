-- CreateTable
CREATE TABLE "FriendConversationRead" (
    "userId" TEXT NOT NULL,
    "conversationId" TEXT NOT NULL,
    "lastReadAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FriendConversationRead_pkey" PRIMARY KEY ("userId","conversationId")
);

-- CreateTable
CREATE TABLE "TripMessageRead" (
    "userId" TEXT NOT NULL,
    "tripId" TEXT NOT NULL,
    "lastReadAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TripMessageRead_pkey" PRIMARY KEY ("userId","tripId")
);

-- CreateIndex
CREATE INDEX "FriendConversationRead_conversationId_idx" ON "FriendConversationRead"("conversationId");

-- CreateIndex
CREATE INDEX "TripMessageRead_tripId_idx" ON "TripMessageRead"("tripId");

-- AddForeignKey
ALTER TABLE "FriendConversationRead" ADD CONSTRAINT "FriendConversationRead_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FriendConversationRead" ADD CONSTRAINT "FriendConversationRead_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES "FriendConversation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripMessageRead" ADD CONSTRAINT "TripMessageRead_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripMessageRead" ADD CONSTRAINT "TripMessageRead_tripId_fkey" FOREIGN KEY ("tripId") REFERENCES "trips"("id") ON DELETE CASCADE ON UPDATE CASCADE;
