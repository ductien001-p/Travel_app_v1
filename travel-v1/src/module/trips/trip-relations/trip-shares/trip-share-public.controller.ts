import { Controller, Get, Header } from '@nestjs/common';
import { ApiExcludeController } from '@nestjs/swagger';
import { ConfigService } from '@nestjs/config';

import { Public } from '../../../../decoration/isPublic.decoration';

const SHARE_PATH_PATTERN = '/s/*';

/**
 * Web side of share links: the fallback page and the domain association files
 * that let Android App Links / iOS Universal Links open the app directly.
 */
@ApiExcludeController()
@Public()
@Controller()
export class TripSharePublicController {
  constructor(private readonly config: ConfigService) {}

  // The token is never echoed back, so the page carries no trip data.
  @Get('s/:token')
  @Header('Content-Type', 'text/html; charset=utf-8')
  @Header('Cache-Control', 'no-store')
  @Header('Referrer-Policy', 'no-referrer')
  @Header('X-Robots-Tag', 'noindex, nofollow')
  @Header(
    'Content-Security-Policy',
    "default-src 'none'; style-src 'unsafe-inline'; frame-ancestors 'none'",
  )
  sharePage(): string {
    return SHARE_FALLBACK_PAGE;
  }

  @Get('.well-known/assetlinks.json')
  @Header('Content-Type', 'application/json')
  assetLinks() {
    const packageName = this.config.get<string>('ANDROID_APP_PACKAGE')?.trim();
    const fingerprints = this.list('ANDROID_SHA256_CERT_FINGERPRINTS');
    if (!packageName || fingerprints.length === 0) return [];
    return [
      {
        relation: ['delegate_permission/common.handle_all_urls'],
        target: {
          namespace: 'android_app',
          package_name: packageName,
          sha256_cert_fingerprints: fingerprints,
        },
      },
    ];
  }

  @Get('.well-known/apple-app-site-association')
  @Header('Content-Type', 'application/json')
  appleAppSiteAssociation() {
    const appIds = this.list('IOS_APP_ID');
    return {
      applinks: {
        apps: [],
        details: appIds.map((appID) => ({
          appID,
          paths: [SHARE_PATH_PATTERN],
        })),
      },
    };
  }

  private list(key: string): string[] {
    return (this.config.get<string>(key) ?? '')
      .split(',')
      .map((value) => value.trim())
      .filter(Boolean);
  }
}

const SHARE_FALLBACK_PAGE = `<!doctype html>
<html lang="vi">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex, nofollow">
<title>Lịch trình chuyến đi</title>
<style>
body{margin:0;font-family:system-ui,-apple-system,sans-serif;background:#f4fbfa;color:#0f2e2b;display:flex;min-height:100vh;align-items:center;justify-content:center}
main{max-width:420px;padding:32px 24px;text-align:center}
h1{font-size:22px;margin:0 0 12px}
p{line-height:1.5;margin:0 0 8px;color:#3d5c58}
</style>
</head>
<body>
<main>
<h1>Bạn được mời xem lịch trình chuyến đi</h1>
<p>Hãy mở liên kết này trên điện thoại đã cài ứng dụng Travel để xem lịch trình.</p>
<p>Nếu chưa có ứng dụng, hãy cài đặt rồi mở lại liên kết.</p>
</main>
</body>
</html>`;
