import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _keyAccessToken = 'access_token';
  static const _keyRefreshToken = 'refresh_token';

  static final TokenStorage instance = TokenStorage._internal(
    kIsWeb
        ? const FlutterSecureStorage(
            webOptions: WebOptions(dbName: 'schat_secure'),
          )
        : const FlutterSecureStorage(),
  );

  final FlutterSecureStorage _storage;
  String? _cachedAccessToken;

  TokenStorage._internal(this._storage);

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _cachedAccessToken = accessToken;
    await Future.wait([
      _storage.write(key: _keyAccessToken, value: accessToken),
      _storage.write(key: _keyRefreshToken, value: refreshToken),
    ]);
  }

  Future<String?> getAccessToken() async {
    _cachedAccessToken ??= await _storage.read(key: _keyAccessToken);
    return _cachedAccessToken;
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: _keyRefreshToken);
  }

  Future<void> clearTokens() async {
    _cachedAccessToken = null;
    await Future.wait([
      _storage.delete(key: _keyAccessToken),
      _storage.delete(key: _keyRefreshToken),
    ]);
  }

  Future<bool> hasTokens() async {
    final token = await getAccessToken();
    return token != null;
  }
}
