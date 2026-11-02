import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/config.dart';

/// Share tokens are 32 random bytes encoded as unpadded base64url.
final _shareTokenPattern = RegExp(r'^[A-Za-z0-9_-]{43}$');

bool isValidShareToken(String token) => _shareTokenPattern.hasMatch(token);

/// In-app path for a shared itinerary link, or null for any other link.
///
/// Only `https://<shareHost>/s/<token>` is accepted; query and fragment are
/// ignored so nothing else from an untrusted link reaches the router.
String? sharedItineraryPathFor(Uri uri, {required String shareHost}) {
  final host = shareHost.trim().toLowerCase();
  if (host.isEmpty) return null;
  if (uri.scheme != 'https' || uri.host.toLowerCase() != host) return null;
  if (uri.hasPort && uri.port != 443) return null;
  if (uri.userInfo.isNotEmpty) return null;

  final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
  if (segments.length != 2 || segments.first != 's') return null;
  final token = segments.last;
  if (!isValidShareToken(token)) return null;
  return '/shared/$token';
}

/// Incoming platform links, abstracted for tests.
abstract interface class DeepLinkSource {
  /// Emits the link that opened the app (cold start), then any later ones.
  Stream<Uri> get links;
}

class AppLinksDeepLinkSource implements DeepLinkSource {
  AppLinksDeepLinkSource({AppLinks? appLinks})
    : _appLinks = appLinks ?? AppLinks();

  final AppLinks _appLinks;

  @override
  Stream<Uri> get links async* {
    // Cold start: the link that launched the process is not always on the stream.
    final initial = await _appLinks.getInitialLink();
    if (initial != null) yield initial;
    yield* _appLinks.uriLinkStream;
  }
}

/// Turns trusted App Links / Universal Links into in-app router paths.
class DeepLinkService {
  const DeepLinkService({required this.source, required this.shareHost});

  final DeepLinkSource source;
  final String shareHost;

  Stream<String> get appPaths => source.links
      .map((uri) => sharedItineraryPathFor(uri, shareHost: shareHost))
      .where((path) => path != null)
      .cast<String>()
      .handleError((Object _) {});
}

final deepLinkServiceProvider = Provider<DeepLinkService>(
  (ref) => DeepLinkService(
    source: AppLinksDeepLinkSource(),
    shareHost: AppConfig.shareHost,
  ),
);
