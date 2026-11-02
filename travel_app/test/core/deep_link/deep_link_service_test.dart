import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/deep_link/deep_link_service.dart';

void main() {
  const host = 'share.travel.test';
  final token = 'Ab9_-' * 8 + 'xyz';

  String? parse(String link) =>
      sharedItineraryPathFor(Uri.parse(link), shareHost: host);

  group('sharedItineraryPathFor', () {
    test('maps a valid share link to the in-app path', () {
      expect(token, hasLength(43));
      expect(parse('https://$host/s/$token'), '/shared/$token');
      expect(parse('https://SHARE.travel.test/s/$token/'), '/shared/$token');
    });

    test('drops query and fragment', () {
      expect(
        parse('https://$host/s/$token?next=https://evil.test#x'),
        '/shared/$token',
      );
    });

    test('rejects other hosts, schemes, ports and credentials', () {
      expect(parse('https://evil.test/s/$token'), isNull);
      expect(parse('https://$host.evil.test/s/$token'), isNull);
      expect(parse('http://$host/s/$token'), isNull);
      expect(parse('travel://$host/s/$token'), isNull);
      expect(parse('https://$host:8443/s/$token'), isNull);
      expect(parse('https://user@$host/s/$token'), isNull);
    });

    test('rejects malformed paths and tokens', () {
      expect(parse('https://$host/s/${token.substring(1)}'), isNull);
      expect(parse('https://$host/s/${token}a'), isNull);
      expect(parse('https://$host/s/${'a' * 42}%2F'), isNull);
      expect(parse('https://$host/x/$token'), isNull);
      expect(parse('https://$host/s/$token/extra'), isNull);
      expect(parse('https://$host/s/'), isNull);
    });

    test('is disabled without a configured host', () {
      expect(
        sharedItineraryPathFor(
          Uri.parse('https://$host/s/$token'),
          shareHost: '',
        ),
        isNull,
      );
    });
  });

  test('DeepLinkService only forwards trusted links', () async {
    final links = StreamController<Uri>();
    final service = DeepLinkService(
      source: _FakeSource(links.stream),
      shareHost: host,
    );
    final paths = <String>[];
    final done = service.appPaths.listen(paths.add).asFuture<void>();

    links
      ..add(Uri.parse('https://evil.test/s/$token'))
      ..add(Uri.parse('https://$host/s/$token'))
      ..addError(Exception('platform failure'))
      ..add(Uri.parse('https://$host/s/short'));
    await links.close();
    await done;

    expect(paths, ['/shared/$token']);
  });
}

class _FakeSource implements DeepLinkSource {
  _FakeSource(this.links);

  @override
  final Stream<Uri> links;
}
