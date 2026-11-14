class SessionExpiredException implements Exception {
  const SessionExpiredException();

  @override
  String toString() {
    return 'Session expired.';
  }
}

class TokenRefreshException implements Exception {
  const TokenRefreshException({required this.message, this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() {
    return message;
  }
}
