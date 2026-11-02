-- Backfills timeline events recorded before 20261013090000_timeline_event_metadata.
-- Data only. Events that cannot be matched unambiguously keep their text content,
-- which clients already render as a fallback.

-- ACTIVITY_ADDED: the activity is inserted in the same transaction right before
-- the event, so the only activity of the trip created within 5 seconds is it.
-- Titles and places are read as they are now, not as they were at the time.
WITH candidates AS (
    SELECT
        event."id" AS "eventId",
        item."id" AS "itemId",
        item."title",
        item."startTime",
        place."name" AS "placeName",
        day."dayNumber",
        COUNT(*) OVER (PARTITION BY event."id") AS "matches"
    FROM "TripTimelineEvent" AS event
    JOIN "ItineraryItem" AS item
        ON item."tripId" = event."tripId"
        AND item."createdAt" BETWEEN event."createdAt" - INTERVAL '5 seconds' AND event."createdAt"
    JOIN "ItineraryDay" AS day ON day."id" = item."dayId"
    JOIN "Place" AS place ON place."id" = item."placeId"
    WHERE event."type" = 'ACTIVITY_ADDED'
        AND (event."metadata" IS NULL OR event."metadata" = 'null'::jsonb)
)
UPDATE "TripTimelineEvent" AS event
SET
    "metadata" = jsonb_build_object(
        'activityTitle', candidates."title",
        'placeName', candidates."placeName",
        'dayNumber', candidates."dayNumber",
        'startTime', to_char(candidates."startTime", 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')
    ),
    "targetType" = 'ACTIVITY',
    "targetId" = candidates."itemId"
FROM candidates
WHERE event."id" = candidates."eventId"
    AND candidates."matches" = 1;

-- TRIP_CREATED: recorded by the owner when a trip leaves the draft state.
INSERT INTO "TripTimelineEvent" (
    "id", "tripId", "type", "memberId", "content", "metadata", "targetType", "targetId", "createdAt"
)
SELECT
    'backfill' || replace(gen_random_uuid()::text, '-', ''),
    trip."id",
    'TRIP_CREATED',
    owner."id",
    'Đã tạo chuyến đi',
    jsonb_build_object(
        'tripName', trip."name",
        'startDate', to_char(trip."startDate", 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'),
        'endDate', to_char(trip."endDate", 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'),
        'destinationCount', (
            SELECT COUNT(*)::int FROM "TripDestination" AS destination
            WHERE destination."tripId" = trip."id"
        )
    ),
    'TRIP',
    trip."id",
    COALESCE(trip."finalizedAt", trip."createdAt")
FROM "trips" AS trip
JOIN "trip_members" AS owner
    ON owner."tripId" = trip."id" AND owner."userId" = trip."ownerId"
WHERE trip."status" <> 'DRAFT'
    AND NOT EXISTS (
        SELECT 1 FROM "TripTimelineEvent" AS event
        WHERE event."tripId" = trip."id" AND event."type" = 'TRIP_CREATED'
    );
