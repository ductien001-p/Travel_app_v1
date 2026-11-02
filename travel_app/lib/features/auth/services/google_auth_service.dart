import 'dart:async';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleAuthService({required String webClientId, required String iosClientId})
    : _webClientId = webClientId,
      _iosClientId = iosClientId;

  final String _webClientId;
  final String _iosClientId;

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void>? _initializeFuture;

  Future<void> _ensureInitialized() {
    return _initializeFuture ??= _initialize();
  }

  Future<void> _initialize() async {
    if (_webClientId.isEmpty) {
      throw const GoogleAuthException('GOOGLE_WEB_CLIENT_ID is missing');
    }

    if (Platform.isIOS && _iosClientId.isEmpty) {
      throw const GoogleAuthException('GOOGLE_IOS_CLIENT_ID is missing');
    }

    await _googleSignIn.initialize(
      /*
       * Android:
       * clientId = null
       *
       * iOS:
       * OAuth Client ID của iOS app.
       */
      clientId: Platform.isIOS ? _iosClientId : null,

      /*
       * Web OAuth Client ID.
       *
       * ID token sẽ có audience này.
       */
      serverClientId: _webClientId,
    );
  }

  /*
   * return null:
   * user chủ động cancel Google login.
   *
   * return String:
   * Google ID token.
   */
  Future<String?> authenticate() async {
    await _ensureInitialized();

    if (!_googleSignIn.supportsAuthenticate()) {
      throw const GoogleAuthException(
        'Google Sign-In is not supported on this platform',
      );
    }

    try {
      final account = await _googleSignIn.authenticate();

      /*
       * google_sign_in 7.x:
       *
       * authentication không còn Future.
       */
      final authentication = account.authentication;

      final idToken = authentication.idToken;

      if (idToken == null || idToken.isEmpty) {
        throw const GoogleAuthException('Google did not return an ID token');
      }

      return idToken;
    } on GoogleSignInException catch (error) {
      /*
       * User bấm Back / Cancel.
       *
       * Không coi đây là backend/auth error.
       */
      if (error.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }

      throw GoogleAuthException(error.description ?? 'Google Sign-In failed');
    }
  }

  Future<void> signOut() async {
    await _ensureInitialized();

    try {
      await _googleSignIn.signOut();
    } catch (_) {
      /*
       * Travel logout không được fail
       * chỉ vì Google SDK signOut lỗi.
       */
    }
  }
}

class GoogleAuthException implements Exception {
  const GoogleAuthException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
