import 'package:flutter/foundation.dart';
import '../../data/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewModel(this._authRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

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
      success: (_) {
        _isLoading = false;
        _isSuccess = true;
        notifyListeners();
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
      success: (_) {
        _isSuccess = false;
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
