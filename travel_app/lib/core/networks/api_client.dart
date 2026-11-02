import 'dart:async';

import 'package:dio/dio.dart';
import 'package:travel_frontend_v1/core/config/config.dart';

import '../storage/token_storage.dart';
import 'api_exception.dart';
import 'auth_interceptor.dart';
import 'token_refresh_exception.dart';
import 'token_refresh_service.dart';

class ApiClient {
  ApiClient({
    required TokenStorage tokenStorage,
    required void Function() onSessionExpired,
  }) {
    /*
     * Config chung.
     */
    final baseOptions = BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,

      connectTimeout: const Duration(seconds: 15),

      receiveTimeout: const Duration(seconds: 15),

      sendTimeout: const Duration(seconds: 15),

      headers: const {
        'Accept': 'application/json',

        'Content-Type': 'application/json',
      },
    );

    /*
     * Dio chính.
     *
     * Tất cả API bình thường đi qua đây.
     */
    _dio = Dio(_copyBaseOptions(baseOptions));

    /*
     * Dio chuyên refresh.
     *
     * KHÔNG AuthInterceptor.
     */
    final refreshDio = Dio(_copyBaseOptions(baseOptions));

    /*
     * Dio chuyên retry request
     * sau refresh.
     *
     * KHÔNG AuthInterceptor.
     */
    final retryDio = Dio(_copyBaseOptions(baseOptions));

    final tokenRefreshService = TokenRefreshService(
      dio: refreshDio,
      tokenStorage: tokenStorage,
    );

    _authInterceptor = AuthInterceptor(
      retryDio: retryDio,

      tokenStorage: tokenStorage,

      tokenRefreshService: tokenRefreshService,

      onSessionExpired: onSessionExpired,

      onTokenRefreshed: () {
        if (!_tokenRefreshes.isClosed) _tokenRefreshes.add(null);
      },
    );

    _dio.interceptors.add(_authInterceptor);

    /*
     * Lưu để dispose.
     */
    _refreshDio = refreshDio;

    _retryDio = retryDio;
  }

  late final Dio _dio;

  late final Dio _refreshDio;

  late final Dio _retryDio;

  late final AuthInterceptor _authInterceptor;

  final _tokenRefreshes = StreamController<void>.broadcast();

  /*
   * Phát mỗi khi access token được làm mới
   * (bởi request HTTP hoặc refreshSession).
   */
  Stream<void> get tokenRefreshes => _tokenRefreshes.stream;

  /*
   * Làm mới phiên bằng luồng refresh chung,
   * cho client không đi qua Dio (socket).
   *
   * Trả null khi phiên đã hết hạn; khi đó
   * phiên đã bị vô hiệu như với lỗi 401.
   */
  Future<String?> refreshSession() => _authInterceptor.refreshSession();

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,

    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,

        queryParameters: queryParameters,

        options: Options(extra: {'skipAuth': !requiresAuth}),
      );

      return response.data as T;
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

  Future<T> post<T>(
    String path, {
    Object? data,

    Map<String, dynamic>? queryParameters,

    Map<String, dynamic>? headers,

    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,

        data: data,

        queryParameters: queryParameters,

        options: Options(extra: {'skipAuth': !requiresAuth}, headers: headers),
      );

      return response.data as T;
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

  Future<T> put<T>(
    String path, {
    Object? data,

    Map<String, dynamic>? queryParameters,

    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,

        data: data,

        queryParameters: queryParameters,

        options: Options(extra: {'skipAuth': !requiresAuth}),
      );

      return response.data as T;
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

  Future<T> patch<T>(
    String path, {
    Object? data,

    Map<String, dynamic>? queryParameters,

    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,

        data: data,

        queryParameters: queryParameters,

        options: Options(extra: {'skipAuth': !requiresAuth}),
      );

      return response.data as T;
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

  Future<T> delete<T>(
    String path, {
    Object? data,

    Map<String, dynamic>? queryParameters,

    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,

        data: data,

        queryParameters: queryParameters,

        options: Options(extra: {'skipAuth': !requiresAuth}),
      );

      return response.data as T;
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

  ApiException _mapDioException(DioException error) {
    /*
     * Refresh token gặp lỗi network /
     * server.
     */
    if (error.error is TokenRefreshException) {
      final refreshError = error.error as TokenRefreshException;

      return ApiException(
        message: refreshError.message,

        code: 'TOKEN_REFRESH_FAILED',
      );
    }

    final response = error.response;

    /*
     * Không có response.
     *
     * thường:
     * timeout
     * DNS
     * offline
     */
    if (response == null) {
      return const ApiException(message: 'Unable to connect to the server.');
    }

    final data = response.data;

    var message = 'Something went wrong.';

    String? code;

    if (data is Map) {
      final rawMessage = data['message'];

      final rawError = data['error'];

      if (rawMessage is String && rawMessage.isNotEmpty) {
        message = rawMessage;
      } else if (rawMessage is List && rawMessage.isNotEmpty) {
        message = rawMessage.map((item) => item.toString()).join('\n');
      } else if (rawError is String && rawError.isNotEmpty) {
        message = rawError;
      } else if (rawError is Map) {
        final nestedMessage = rawError['message'];

        if (nestedMessage is String && nestedMessage.isNotEmpty) {
          message = nestedMessage;
        }
      }

      code = data['code']?.toString();
    }

    return ApiException(
      message: message,

      statusCode: response.statusCode,

      code: code,

      details: data,
    );
  }

  BaseOptions _copyBaseOptions(BaseOptions source) {
    return BaseOptions(
      baseUrl: source.baseUrl,

      connectTimeout: source.connectTimeout,

      receiveTimeout: source.receiveTimeout,

      sendTimeout: source.sendTimeout,

      headers: Map<String, dynamic>.from(source.headers),

      responseType: source.responseType,

      contentType: source.contentType,

      validateStatus: source.validateStatus,

      followRedirects: source.followRedirects,

      maxRedirects: source.maxRedirects,

      receiveDataWhenStatusError: source.receiveDataWhenStatusError,
    );
  }

  void close() {
    _tokenRefreshes.close();

    _dio.close(force: true);

    _refreshDio.close(force: true);

    _retryDio.close(force: true);
  }
}
