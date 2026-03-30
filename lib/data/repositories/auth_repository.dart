import '../local/token_storage.dart';

class AuthRepository {
  final TokenStorage _tokenStorage;

  AuthRepository(this._tokenStorage);

  Future<bool> isLoggedIn() => _tokenStorage.hasTokens();

  Future<void> login({required String email, required String password}) async {
    throw UnimplementedError('AuthRepository.login not implemented');
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    throw UnimplementedError('AuthRepository.register not implemented');
  }
}
