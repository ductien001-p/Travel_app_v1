import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/profile/application/change_password.dart';
import 'package:travel_frontend_v1/features/public-images/data/datasources/public_images_datasource.dart';
import 'package:travel_frontend_v1/features/public-images/data/models/public_image_models.dart';
import 'package:travel_frontend_v1/features/public-images/data/repositories/public_images_repository.dart';

void main() {
  test('rejects a short or mismatched new password', () {
    expect(
      validateChangePassword(
        currentPassword: 'old-password',
        newPassword: 'short',
        confirmPassword: 'short',
      ),
      'Mật khẩu mới cần ít nhất 8 ký tự.',
    );
    expect(
      validateChangePassword(
        currentPassword: 'old-password',
        newPassword: 'new-password',
        confirmPassword: 'other-password',
      ),
      'Mật khẩu xác nhận không khớp.',
    );
    expect(
      validateChangePassword(
        currentPassword: 'old-password',
        newPassword: 'new-password',
        confirmPassword: 'new-password',
      ),
      isNull,
    );
  });

  test('maps a wrong current password to a safe message', () {
    expect(
      changePasswordFailureMessage(
        const ApiException(message: 'Current password is incorrect'),
      ),
      'Mật khẩu hiện tại không đúng.',
    );
  });

  test('public image album does not fall back to datamock', () {
    final repository = PublicImagesRepository(dataSource: _MissingAlbum());
    expect(repository.getAlbum('social-post-1'), throwsA(isA<Exception>()));
  });
}

class _MissingAlbum implements PublicImagesDataSource {
  @override
  Future<PublicImageAlbum> getAlbum(String albumId) async {
    throw Exception('not found');
  }
}
