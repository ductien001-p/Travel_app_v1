import 'package:travel_frontend_v1/features/auth/services/google_auth_service.dart';

import '../../../../core/storage/token_storage.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepository {
  AuthRepository({
    required AuthRemoteDataSource remoteDataSource,
    required TokenStorage tokenStorage,
    required GoogleAuthService googleAuthService,
  }) : _remoteDataSource = remoteDataSource,
       _tokenStorage = tokenStorage,
       _googleAuthService = googleAuthService;

  final AuthRemoteDataSource _remoteDataSource;

  final TokenStorage _tokenStorage;

  final GoogleAuthService _googleAuthService;

  Future<bool> restoreSession() async {
    final refreshToken = await _tokenStorage.readRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    try {
      final tokens = await _remoteDataSource.refresh(
        refreshToken: refreshToken,
      );

      await _tokenStorage.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );

      return true;
    } catch (_) {
      await _tokenStorage.clearTokens();

      return false;
    }
  }

  Future<void> login({required String email, required String password}) async {
    final tokens = await _remoteDataSource.login(
      email: email,
      password: password,
    );

    await _tokenStorage.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }

  Future<bool> googleLogin() async {
    /*
     * ==========================================
     * STEP 1:
     * Native Google login
     * ==========================================
     */

    final idToken = await _googleAuthService.authenticate();

    /*
     * User cancel.
     */
    if (idToken == null) {
      return false;
    }

    try {
      /*
       * ==========================================
       * STEP 2:
       * Backend verify Google token
       * ==========================================
       */

      final tokens = await _remoteDataSource.googleLogin(idToken: idToken);

      /*
       * ==========================================
       * STEP 3:
       * Travel session
       * ==========================================
       */

      await _tokenStorage.saveTokens(
        accessToken: tokens.accessToken,

        refreshToken: tokens.refreshToken,
      );

      return true;
    } catch (_) {
      /*
       * Backend reject account, ví dụ:
       *
       * email đã đăng ký LOCAL.
       *
       * Sign out Google local session để
       * lần thử sau user có thể chọn account khác.
       */
      await _googleAuthService.signOut();

      rethrow;
    }
  }

  Future<void> signOutGoogle() {
    return _googleAuthService.signOut();
  }

  Future<void> logout({
    required String refreshToken,
    required String installationId,
  }) async {
    try {
      await _remoteDataSource.logout(
        refreshToken: refreshToken,
        installationId: installationId,
      );
    } finally {
      await _tokenStorage.clearTokens();
    }
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    await _remoteDataSource.register(
      email: email,
      username: username,
      password: password,
    );

    /*
     * KHÔNG save token ở đây
     * nếu user vừa register vẫn INACTIVE.
     */
  }

  Future<void> verifyEmail({
    required String email,
    required String token,
  }) async {
    final tokens = await _remoteDataSource.verifyEmail(
      email: email,
      token: token,
    );

    /*
     * Verify thành công → user ACTIVE.
     */
    await _tokenStorage.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) {
    return _remoteDataSource.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }

  Future<void> requestPasswordReset({required String email}) {
    return _remoteDataSource.requestPasswordReset(email: email);
  }

  Future<void> resendVerification({required String email}) {
    return _remoteDataSource.resendVerification(email: email);
  }

  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) {
    return _remoteDataSource.resetPassword(
      email: email,
      token: token,
      newPassword: newPassword,
    );
  }
}
