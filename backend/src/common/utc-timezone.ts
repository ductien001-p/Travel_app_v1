// Must be the first import of every entry point: the whole backend runs in UTC
// regardless of the host machine or container timezone.
process.env.TZ = 'UTC';
