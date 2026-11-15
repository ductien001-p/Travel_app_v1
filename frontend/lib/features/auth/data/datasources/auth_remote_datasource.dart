import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/networks/api_response_parser.dart';
import 'package:travel_frontend_v1/features/auth/data/models/google_login_request.dart';

import '../models/auth_tokens.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<AuthTokens> login({
    required String email,
    required String password,
  }) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/auth/login',
      requiresAuth: false,
      data: {'email': email, 'password': password},
    );

    return _parseTokens(body);
  }

  Future<AuthTokens> googleLogin({required String idToken}) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/auth/google',

      requiresAuth: false,

      data: GoogleLoginRequest(idToken: idToken).toJson(),
    );

    return _parseTokens(response);
  }

  Future<AuthTokens> refresh({required String refreshToken}) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/auth/refresh',
      requiresAuth: false,
      data: {'refreshToken': refreshToken},
    );

    return _parseTokens(body);
  }

  Future<void> logout({
    required String refreshToken,
    required String installationId,
  }) async {
    await _apiClient.post<Object?>(
      '/auth/logout-one',
      data: {'refreshToken': refreshToken, 'installationId': installationId},
    );
  }

  AuthTokens _parseTokens(Map<String, dynamic> body) {
    final data = ApiResponseParser.dataMap(body);

    final rawTokens = data['tokens'];

    if (rawTokens is Map) {
      return AuthTokens.fromJson(Map<String, dynamic>.from(rawTokens));
    }

    return AuthTokens.fromJson(data);
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    await _apiClient.post<Object?>(
      '/auth/register',

      requiresAuth: false,

      data: {'email': email, 'username': username, 'password': password},
    );
  }

  Future<AuthTokens> verifyEmail({
    required String email,
    required String token,
  }) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/auth/verify-email',

      requiresAuth: false,

      data: {'email': email, 'token': token},
    );

    return _parseTokens(body);
  }

  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    await _apiClient.post<Object?>(
      '/auth/reset-password',
      requiresAuth: false,
      data: {'email': email, 'token': token, 'password': newPassword},
    );
  }

  Future<void> resendVerification({required String email}) async {
    await _apiClient.post<Object?>(
      '/auth/resend-verification-email',
      requiresAuth: false,
      data: {'email': email},
    );
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    await _apiClient.post<Object?>(
      '/auth/change-password',
      data: {'oldPassword': oldPassword, 'newPassword': newPassword},
    );
  }

  Future<void> requestPasswordReset({required String email}) async {
    await _apiClient.post<Object?>(
      '/auth/send-password-reset-code',
      requiresAuth: false,
      data: {'email': email},
    );
  }
}
