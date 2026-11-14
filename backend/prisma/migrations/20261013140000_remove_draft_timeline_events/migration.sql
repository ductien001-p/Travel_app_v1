-- Data only. Drafts are private planning: the timeline now records nothing while a
-- trip is a draft, and its history starts with TRIP_CREATED. Removes the events
-- recorded before that rule, so every trip follows it.

DELETE FROM "TripTimelineEvent" AS event
USING "trips" AS trip
WHERE trip."id" = event."tripId"
    AND trip."status" = 'DRAFT';

DELETE FROM "TripTimelineEvent" AS event
WHERE event."type" <> 'TRIP_CREATED'
    AND event."createdAt" < (
        SELECT MIN(created."createdAt")
        FROM "TripTimelineEvent" AS created
        WHERE created."tripId" = event."tripId"
            AND created."type" = 'TRIP_CREATED'
    );
