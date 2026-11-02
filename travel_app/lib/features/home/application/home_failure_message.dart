import 'package:travel_frontend_v1/core/networks/api_exception.dart';

/// User-facing copy for a failed Home request. Never returns [Object.toString].
String homeFailureMessage(Object error) {
  if (error is ApiException && error.statusCode == 401) {
    return 'Phiên đăng nhập đã hết hạn';
  }
  if (error is ApiException && error.message.trim().isNotEmpty) {
    return error.message.trim();
  }
  return 'Đã xảy ra lỗi. Vui lòng thử lại.';
}

bool homeFailureIsUnauthorized(Object error) =>
    error is ApiException && error.statusCode == 401;
