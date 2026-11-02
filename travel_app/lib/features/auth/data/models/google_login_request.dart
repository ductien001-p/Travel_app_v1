class GoogleLoginRequest {
  const GoogleLoginRequest({required this.idToken});

  final String idToken;

  Map<String, dynamic> toJson() {
    return {'idToken': idToken};
  }
}
