class AuthTokens {
  const AuthTokens({required this.accessToken, required this.refreshToken});

  final String accessToken;

  final String refreshToken;

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    final accessToken = json['accessToken'];

    final refreshToken = json['refreshToken'];

    if (accessToken is! String || accessToken.isEmpty) {
      throw const FormatException('accessToken is missing from auth response.');
    }

    if (refreshToken is! String || refreshToken.isEmpty) {
      throw const FormatException(
        'refreshToken is missing from auth response.',
      );
    }

    return AuthTokens(accessToken: accessToken, refreshToken: refreshToken);
  }
}
