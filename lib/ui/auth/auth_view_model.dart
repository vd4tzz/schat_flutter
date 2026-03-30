import 'package:flutter/foundation.dart';
import '../../data/repositories/auth_repository.dart';

enum AuthState { idle, loading, error }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository);

  AuthState _state = AuthState.idle;
  AuthState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> login({required String email, required String password}) async {
    _set(AuthState.loading);
    try {
      await _authRepository.login(email: email, password: password);
      _set(AuthState.idle);
    } catch (e) {
      _errorMessage = e.toString();
      _set(AuthState.error);
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _set(AuthState.loading);
    try {
      await _authRepository.register(
        name: name,
        email: email,
        password: password,
      );
      _set(AuthState.idle);
    } catch (e) {
      _errorMessage = e.toString();
      _set(AuthState.error);
    }
  }

  void clearError() {
    if (_state == AuthState.error) {
      _errorMessage = null;
      _set(AuthState.idle);
    }
  }

  void _set(AuthState s) {
    _state = s;
    notifyListeners();
  }
}
