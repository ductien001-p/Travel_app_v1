-- Idempotent legacy backfill. Reruns insert nothing once a row exists.
-- OPEN/FULL: PUBLIC + UPCOMING + expiresAt (startDate - 24h) still in the future
-- + description of at least 20 characters + a cover. No 48-hour gate, so a
-- trip 24–48 hours from departure stays on the feed. previousVisibility is PUBLIC.
-- Owners may keep more than 3 posts.
-- NOT_PUBLISHED: same audience, but only when departure is at least 48 hours
-- away and the description or cover is missing. The one-shot notifier sends
-- only these rows. Trips that miss the feed only because they leave within
-- 48 hours, or whose expiresAt has passed, get no row and no notification.

INSERT INTO "trip_recruitments" (
    "tripId",
    "state",
    "requirements",
    "estimatedBudgetPerPerson",
    "publishedAt",
    "expiresAt",
    "draftStep",
    "origin",
    "previousVisibility",
    "notifiedAt",
    "createdAt",
    "updatedAt"
)
SELECT
    t.id,
    CASE
        WHEN active.member_count >= t."maxMembers" THEN 'FULL'::"RECRUITMENT_STATE"
        ELSE 'OPEN'::"RECRUITMENT_STATE"
    END,
    NULL,
    NULL,
    CURRENT_TIMESTAMP,
    t."startDate" - INTERVAL '24 hours',
    NULL,
    'LEGACY_BACKFILL'::"RECRUITMENT_ORIGIN",
    'PUBLIC'::"TRIP_VISIBILITY",
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM "trips" t
JOIN LATERAL (
    SELECT COUNT(*)::int AS member_count
    FROM "trip_members" m
    WHERE m."tripId" = t.id
      AND m.status = 'ACTIVE'::"MEMBER_STATUS"
) active ON true
WHERE t.status = 'UPCOMING'::"TRIP_STATUS"
  AND t.visibility = 'PUBLIC'::"TRIP_VISIBILITY"
  AND t."startDate" - INTERVAL '24 hours' > CURRENT_TIMESTAMP
  AND char_length(btrim(coalesce(t.description, ''))) >= 20
  AND t."coverMediaId" IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM "trip_recruitments" existing WHERE existing."tripId" = t.id
  );

INSERT INTO "trip_recruitments" (
    "tripId",
    "state",
    "requirements",
    "estimatedBudgetPerPerson",
    "publishedAt",
    "expiresAt",
    "draftStep",
    "origin",
    "previousVisibility",
    "notifiedAt",
    "createdAt",
    "updatedAt"
)
SELECT
    t.id,
    'NOT_PUBLISHED'::"RECRUITMENT_STATE",
    NULL,
    NULL,
    NULL,
    t."startDate" - INTERVAL '24 hours',
    NULL,
    'LEGACY_BACKFILL'::"RECRUITMENT_ORIGIN",
    NULL,
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM "trips" t
WHERE t.status = 'UPCOMING'::"TRIP_STATUS"
  AND t.visibility = 'PUBLIC'::"TRIP_VISIBILITY"
  AND t."startDate" >= CURRENT_TIMESTAMP + INTERVAL '48 hours'
  AND (
      char_length(btrim(coalesce(t.description, ''))) < 20
      OR t."coverMediaId" IS NULL
  )
  AND NOT EXISTS (
      SELECT 1 FROM "trip_recruitments" existing WHERE existing."tripId" = t.id
  );
