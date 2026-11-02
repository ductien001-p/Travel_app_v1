import * as fs from 'fs';
import * as path from 'path';

describe('GET /trips/mine route order', () => {
  it('registers mine/summary and mine before the :id handler', () => {
    const source = fs.readFileSync(
      path.join(__dirname, 'trips.controller.ts'),
      'utf8',
    );
    const summary = source.indexOf("@Get('mine/summary')");
    const mine = source.indexOf("@Get('mine')");
    const byId = source.indexOf("@Get(':id')");
    expect(summary).toBeGreaterThanOrEqual(0);
    expect(summary).toBeLessThan(mine);
    expect(mine).toBeLessThan(byId);
  });
});
