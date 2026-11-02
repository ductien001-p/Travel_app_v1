export default function utcGlobalSetup(): void {
  process.env.TZ = 'UTC';
}
