CREATE TABLE "DestinationCatalog" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "lat" DOUBLE PRECISION NOT NULL,
    "lng" DOUBLE PRECISION NOT NULL,
    "type" TEXT,
    "highlights" TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[],
    "coverMediaId" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "DestinationCatalog_pkey" PRIMARY KEY ("id")
);

ALTER TABLE "TripDestination"
ADD COLUMN "destinationId" TEXT,
ADD COLUMN "destinationType" TEXT,
ADD COLUMN "highlights" TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[],
ADD COLUMN "coverMediaId" TEXT;

CREATE UNIQUE INDEX "DestinationCatalog_name_country_key"
ON "DestinationCatalog"("name", "country");
CREATE INDEX "DestinationCatalog_country_name_idx"
ON "DestinationCatalog"("country", "name");
CREATE INDEX "DestinationCatalog_coverMediaId_idx"
ON "DestinationCatalog"("coverMediaId");
CREATE INDEX "TripDestination_destinationId_idx"
ON "TripDestination"("destinationId");
CREATE INDEX "TripDestination_coverMediaId_idx"
ON "TripDestination"("coverMediaId");

ALTER TABLE "DestinationCatalog"
ADD CONSTRAINT "DestinationCatalog_coverMediaId_fkey"
FOREIGN KEY ("coverMediaId") REFERENCES "UploadedMedia"("id")
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "TripDestination"
ADD CONSTRAINT "TripDestination_destinationId_fkey"
FOREIGN KEY ("destinationId") REFERENCES "DestinationCatalog"("id")
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "TripDestination"
ADD CONSTRAINT "TripDestination_coverMediaId_fkey"
FOREIGN KEY ("coverMediaId") REFERENCES "UploadedMedia"("id")
ON DELETE SET NULL ON UPDATE CASCADE;
