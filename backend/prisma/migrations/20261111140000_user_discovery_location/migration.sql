-- AlterTable
ALTER TABLE "User" ADD COLUMN IF NOT EXISTS "discoveryLat" DOUBLE PRECISION;
ALTER TABLE "User" ADD COLUMN IF NOT EXISTS "discoveryLng" DOUBLE PRECISION;
ALTER TABLE "User" ADD COLUMN IF NOT EXISTS "discoveryLocatedAt" TIMESTAMP(3);
ALTER TABLE "User" ADD COLUMN IF NOT EXISTS "shareLocationForDiscovery" BOOLEAN NOT NULL DEFAULT false;

-- CreateIndex
CREATE INDEX IF NOT EXISTS "User_discoveryLat_discoveryLng_idx" ON "User"("discoveryLat", "discoveryLng");
