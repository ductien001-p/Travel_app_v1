import 'package:dio/dio.dart';

import '../storage/token_storage.dart';
import 'token_refresh_exception.dart';
import 'token_refresh_service.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio retryDio,
    required TokenStorage tokenStorage,
    required TokenRefreshService tokenRefreshService,
    required void Function() onSessionExpired,
    void Function()? onTokenRefreshed,
  }) : _retryDio = retryDio,
       _tokenStorage = tokenStorage,
       _tokenRefreshService = tokenRefreshService,
       _onSessionExpired = onSessionExpired,
       _onTokenRefreshed = onTokenRefreshed;

  final Dio _retryDio;

  final TokenStorage _tokenStorage;

  final TokenRefreshService _tokenRefreshService;

  final void Function() _onSessionExpired;

  final void Function()? _onTokenRefreshed;

  /*
   * Chỉ có tối đa một refresh request
   * chạy tại cùng một thời điểm.
   */
  Future<String>? _refreshFuture;

  static const String _skipAuthKey = 'skipAuth';

  static const String _retriedKey = 'authRetried';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final skipAuth = options.extra[_skipAuthKey] == true;

    if (skipAuth) {
      handler.next(options);
      return;
    }

    final accessToken = await _tokenStorage.readAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;

    /*
     * Không phải 401.
     *
     * Không liên quan refresh token.
     */
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    /*
     * Public API:
     *
     * login
     * register
     * refresh
     *
     * không được auto refresh.
     */
    final skipAuth = request.extra[_skipAuthKey] == true;

    if (skipAuth) {
      handler.next(err);
      return;
    }

    /*
     * Request này đã retry một lần rồi
     * mà vẫn 401.
     *
     * Không retry vô hạn.
     */
    final alreadyRetried = request.extra[_retriedKey] == true;

    if (alreadyRetried) {
      await _expireSession();

      handler.next(err);

      return;
    }

    try {
      /*
       * Token mà request bị lỗi đã sử dụng.
       */
      final failedAccessToken = _extractBearerToken(
        request.headers['Authorization'],
      );

      /*
       * Token hiện tại trong storage.
       */
      final currentAccessToken = await _tokenStorage.readAccessToken();

      late final String newAccessToken;

      /*
       * Có thể request A đã refresh token
       * xong trong lúc request B vẫn đang
       * bay trên network.
       *
       * Request B trả 401 với token cũ,
       * nhưng storage đã có token mới.
       *
       * Khi đó KHÔNG refresh lần nữa.
       */
      if (currentAccessToken != null &&
          currentAccessToken.isNotEmpty &&
          failedAccessToken != null &&
          failedAccessToken != currentAccessToken) {
        newAccessToken = currentAccessToken;
      } else {
        newAccessToken = await _refreshSingleFlight();
      }

      /*
       * Gắn token mới.
       */
      request.headers['Authorization'] = 'Bearer $newAccessToken';

      /*
       * Đánh dấu đã retry.
       *
       * Tránh loop:
       *
       * 401 → refresh → retry → 401
       * → refresh → retry...
       */
      request.extra[_retriedKey] = true;

      /*
       * Retry bằng Dio riêng,
       * không có AuthInterceptor.
       */
      final response = await _retryDio.fetch<dynamic>(request);

      handler.resolve(response);
    } on SessionExpiredException {
      await _expireSession();

      handler.next(err);
    } on TokenRefreshException catch (refreshError) {
      /*
       * Refresh thất bại do lỗi mạng /
       * server.
       *
       * Không logout.
       */
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          type: DioExceptionType.unknown,
          error: refreshError,
          message: refreshError.message,
        ),
      );
    } on DioException catch (retryError) {
      /*
       * Request retry vẫn lỗi.
       */
      if (retryError.response?.statusCode == 401) {
        await _expireSession();
      }

      handler.reject(retryError);
    } catch (unknownError) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          type: DioExceptionType.unknown,
          error: unknownError,
          message: 'Authentication request failed.',
        ),
      );
    }
  }

  Future<String> _refreshSingleFlight() {
    /*
     * Đã có refresh đang chạy.
     *
     * Request hiện tại chỉ chờ nó.
     */
    final existing = _refreshFuture;

    if (existing != null) {
      return existing;
    }

    /*
     * Request đầu tiên tạo refresh.
     */
    _refreshFuture = _performRefresh();

    return _refreshFuture!;
  }

  /*
   * Refresh cho client không đi qua Dio
   * (ví dụ socket realtime).
   *
   * Dùng chung single-flight và luồng
   * hết phiên với request HTTP.
   *
   * Trả null khi phiên đã hết hạn.
   */
  Future<String?> refreshSession() async {
    try {
      return await _refreshSingleFlight();
    } on SessionExpiredException {
      await _expireSession();

      return null;
    }
  }

  Future<String> _performRefresh() async {
    try {
      final accessToken = await _tokenRefreshService.refreshAccessToken();

      _onTokenRefreshed?.call();

      return accessToken;
    } finally {
      /*
       * Refresh hoàn tất.
       *
       * Lần 401 sau có thể tạo
       * refresh mới.
       */
      _refreshFuture = null;
    }
  }

  Future<void> _expireSession() async {
    await _tokenStorage.clearTokens();

    _onSessionExpired();
  }

  String? _extractBearerToken(Object? header) {
    if (header is! String) {
      return null;
    }

    const prefix = 'Bearer ';

    if (!header.startsWith(prefix)) {
      return null;
    }

    return header.substring(prefix.length);
  }
}
