import 'dotenv/config';
import pg from 'pg';

const client = new pg.Client({ connectionString: process.env.DATABASE_URL });

try {
  await client.connect();
  const result = await client.query(`
    SELECT
      COUNT(*)::int AS duplicate_groups,
      COALESCE(SUM(duplicate_count - 1), 0)::int AS redundant_rows
    FROM (
      SELECT COUNT(*)::int AS duplicate_count
      FROM "TripCheckin" AS checkin
      JOIN "ItineraryItem" AS item ON item."id" = checkin."activityId"
      JOIN "trip_members" AS member ON member."id" = checkin."memberId"
      GROUP BY item."tripId", member."userId", item."placeId"
      HAVING COUNT(*) > 1
    ) AS duplicates
  `);
  console.log(JSON.stringify(result.rows[0]));
} finally {
  await client.end();
}
