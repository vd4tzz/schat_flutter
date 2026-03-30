import '../local/token_storage.dart';

class AuthRepository {
  final TokenStorage _tokenStorage;

  AuthRepository(this._tokenStorage);

  Future<bool> isLoggedIn() => _tokenStorage.hasTokens();
}
