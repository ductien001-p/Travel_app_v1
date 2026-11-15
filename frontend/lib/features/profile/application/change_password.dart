import 'package:travel_frontend_v1/core/networks/api_exception.dart';

/// Returns a message when the form is invalid, otherwise null.
String? validateChangePassword({
  required String currentPassword,
  required String newPassword,
  required String confirmPassword,
}) {
  if (currentPassword.isEmpty || newPassword.isEmpty) {
    return 'Nhập mật khẩu hiện tại và mật khẩu mới.';
  }
  if (newPassword.length < 8) {
    return 'Mật khẩu mới cần ít nhất 8 ký tự.';
  }
  if (newPassword != confirmPassword) {
    return 'Mật khẩu xác nhận không khớp.';
  }
  if (newPassword == currentPassword) {
    return 'Mật khẩu mới phải khác mật khẩu hiện tại.';
  }
  return null;
}

String changePasswordFailureMessage(Object error) {
  final raw = error is ApiException ? error.message : error.toString();
  final text = raw.toLowerCase();
  if (text.contains('incorrect') || text.contains('current password')) {
    return 'Mật khẩu hiện tại không đúng.';
  }
  if (text.contains('local account') || text.contains('only allowed')) {
    return 'Tài khoản đăng nhập Google không đổi mật khẩu tại đây.';
  }
  if (error is ApiException && error.message.trim().isNotEmpty) {
    return 'Không đổi được mật khẩu. Kiểm tra lại và thử lại.';
  }
  return 'Không đổi được mật khẩu. Thử lại.';
}
