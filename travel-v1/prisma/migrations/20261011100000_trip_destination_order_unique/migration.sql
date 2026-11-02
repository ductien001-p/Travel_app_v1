-- Renumber trips that already contain duplicate orders, keeping travel-date order.
WITH ranked AS (
  SELECT "id",
    ROW_NUMBER() OVER (
      PARTITION BY "tripId"
      ORDER BY "order", "startDate", "id"
    ) AS "newOrder"
  FROM "TripDestination"
  WHERE "tripId" IN (
    SELECT "tripId"
    FROM "TripDestination"
    GROUP BY "tripId", "order"
    HAVING COUNT(*) > 1
  )
)
UPDATE "TripDestination" AS destination
SET "order" = ranked."newOrder"
FROM ranked
WHERE destination."id" = ranked."id";

-- DropIndex
DROP INDEX "TripDestination_tripId_order_idx";

-- CreateIndex
CREATE UNIQUE INDEX "TripDestination_tripId_order_key" ON "TripDestination"("tripId", "order");
