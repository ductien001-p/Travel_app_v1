import 'package:dio/dio.dart';

import '../storage/token_storage.dart';
import 'api_response_parser.dart';
import 'token_refresh_exception.dart';

class TokenRefreshService {
  TokenRefreshService({required Dio dio, required TokenStorage tokenStorage})
    : _dio = dio,
      _tokenStorage = tokenStorage;

  final Dio _dio;

  final TokenStorage _tokenStorage;

  Future<String> refreshAccessToken() async {
    final refreshToken = await _tokenStorage.readRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      await _tokenStorage.clearTokens();

      throw const SessionExpiredException();
    }

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/refresh',

        data: {'refreshToken': refreshToken},
      );

      final body = response.data;

      if (body == null) {
        throw const TokenRefreshException(
          message: 'Refresh response is empty.',
        );
      }

      final data = ApiResponseParser.dataMap(body);

      final rawTokens = data['tokens'];

      final Map<String, dynamic> tokenData;

      if (rawTokens is Map) {
        tokenData = Map<String, dynamic>.from(rawTokens);
      } else {
        tokenData = data;
      }

      final accessToken = tokenData['accessToken'];

      final newRefreshToken = tokenData['refreshToken'];

      if (accessToken is! String || accessToken.isEmpty) {
        throw const TokenRefreshException(
          message: 'Refresh response does not contain accessToken.',
        );
      }

      if (newRefreshToken is! String || newRefreshToken.isEmpty) {
        throw const TokenRefreshException(
          message: 'Refresh response does not contain refreshToken.',
        );
      }

      await _tokenStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: newRefreshToken,
      );

      return accessToken;
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode;

      /*
       * Refresh token không hợp lệ /
       * đã hết hạn.
       */
      if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
        await _tokenStorage.clearTokens();

        throw const SessionExpiredException();
      }

      /*
       * Network / timeout / server 5xx.
       *
       * Không xóa token ở đây vì đây có
       * thể chỉ là lỗi tạm thời.
       */
      throw TokenRefreshException(
        message: 'Unable to refresh session.',
        cause: error,
      );
    }
  }
}
