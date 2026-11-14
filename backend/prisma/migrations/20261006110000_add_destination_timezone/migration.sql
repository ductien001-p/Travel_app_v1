-- Add nullable IANA timezone ownership without inventing defaults for existing data.
ALTER TABLE "DestinationCatalog" ADD COLUMN "timeZone" TEXT;
ALTER TABLE "TripDestination" ADD COLUMN "timeZone" TEXT;

-- Existing rows intentionally remain NULL. Catalog operators must populate an
-- authoritative IANA identifier; new trip destinations snapshot that value.
