-- Every trip date and activity time is evaluated in UTC; per-destination zones are no longer used.
ALTER TABLE "DestinationCatalog" DROP COLUMN "timeZone";
ALTER TABLE "TripDestination" DROP COLUMN "timeZone";
