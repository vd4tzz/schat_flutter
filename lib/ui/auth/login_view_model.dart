import 'package:flutter/foundation.dart';
import '../../data/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  VoidCallback? _onLoginSuccess;

  LoginViewModel(this._authRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setOnLoginSuccess(VoidCallback callback) {
    _onLoginSuccess = callback;
  }

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _authRepository.login(
      identifier: identifier,
      password: password,
    );

    result.when(
      success: (data) {
        _isLoading = false;
        notifyListeners();
        _onLoginSuccess?.call();
      },
      failure: (message, code) {
        _errorMessage = message;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> logout() async {
    final result = await _authRepository.logout();
    result.when(
      success: (data) {
        _errorMessage = null;
      },
      failure: (message, code) {},
    );
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
