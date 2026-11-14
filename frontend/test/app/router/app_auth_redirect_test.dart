import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/app/router/app_router.dart';
import 'package:travel_frontend_v1/features/auth/application/auth_status.dart';

void main() {
  final shared = '/shared/${'a' * 43}';
  final encodedShared = Uri.encodeQueryComponent(shared);

  String? redirect(AsyncValue<AuthStatus> auth, String location) {
    final uri = Uri.parse(location);
    return appAuthRedirect(auth: auth, location: uri.path, uri: uri);
  }

  const loading = AsyncLoading<AuthStatus>();
  const signedOut = AsyncData(AuthStatus.unauthenticated);
  const signedIn = AsyncData(AuthStatus.authenticated);

  test('keeps the target through splash and login', () {
    expect(redirect(loading, shared), '/splash?from=$encodedShared');
    expect(redirect(loading, '/splash?from=$encodedShared'), isNull);
    expect(
      redirect(signedOut, '/splash?from=$encodedShared'),
      '/login?from=$encodedShared',
    );
    expect(redirect(signedOut, '/login?from=$encodedShared'), isNull);
    expect(redirect(signedIn, '/login?from=$encodedShared'), shared);
    expect(redirect(signedIn, '/splash?from=$encodedShared'), shared);
  });

  test('a signed-out deep link goes to login with from', () {
    expect(redirect(signedOut, shared), '/login?from=$encodedShared');
    expect(
      redirect(
        AsyncError<AuthStatus>(Exception('x'), StackTrace.empty),
        shared,
      ),
      '/login?from=$encodedShared',
    );
  });

  test('keeps the default behaviour without a target', () {
    expect(redirect(loading, '/home'), '/splash');
    expect(redirect(signedOut, '/home'), '/login');
    expect(redirect(signedIn, '/login'), '/home');
    expect(redirect(signedIn, '/splash'), '/home');
    expect(redirect(signedIn, shared), isNull);
    expect(redirect(loading, '/login'), isNull);
  });

  test('ignores unsafe return targets', () {
    for (final from in [
      'https://evil.test/x',
      '//evil.test/x',
      r'/\evil.test',
      'evil',
      '/login',
      '/splash?from=/x',
    ]) {
      final query = Uri.encodeQueryComponent(from);
      expect(redirect(signedIn, '/login?from=$query'), '/home', reason: from);
    }
  });

  test('safeReturnPath', () {
    expect(
      safeReturnPath('/trips/1/itinerary?dayId=d'),
      '/trips/1/itinerary?dayId=d',
    );
    expect(safeReturnPath(null), isNull);
    expect(safeReturnPath('/${'a' * 600}'), isNull);
    expect(safeReturnPath('/home'), isNull);
  });
}
