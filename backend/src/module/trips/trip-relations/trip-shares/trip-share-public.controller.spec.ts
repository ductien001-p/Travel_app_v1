import { TripSharePublicController } from './trip-share-public.controller';

describe('TripSharePublicController', () => {
  const controller = (env: Record<string, string>) =>
    new TripSharePublicController({
      get: (key: string) => env[key],
    } as never);

  it('publishes Android app links only when fully configured', () => {
    expect(controller({}).assetLinks()).toEqual([]);

    const links = controller({
      ANDROID_APP_PACKAGE: 'com.company.app',
      ANDROID_SHA256_CERT_FINGERPRINTS: 'AA:BB, CC:DD',
    }).assetLinks();

    expect(links).toEqual([
      expect.objectContaining({
        target: {
          namespace: 'android_app',
          package_name: 'com.company.app',
          sha256_cert_fingerprints: ['AA:BB', 'CC:DD'],
        },
      }),
    ]);
  });

  it('limits iOS universal links to share paths', () => {
    const association = controller({
      IOS_APP_ID: 'TEAM.com.company.app',
    }).appleAppSiteAssociation();

    expect(association.applinks.details).toEqual([
      { appID: 'TEAM.com.company.app', paths: ['/s/*'] },
    ]);
  });

  it('serves a fallback page without trip data', () => {
    const page = controller({}).sharePage();

    expect(page).toContain('<!doctype html>');
    expect(page).not.toMatch(/token/i);
  });
});
