import 'package:flutter/foundation.dart';
import '../../data/repositories/auth_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  RegisterViewModel(this._authRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int? _otpExpiresIn;
  int? get otpExpiresIn => _otpExpiresIn;

  Future<void> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _authRepository.register(
      fullName: fullName,
      username: username,
      email: email,
      password: password,
    );

    result.when(
      success: (expireSeconds) {
        _otpExpiresIn = expireSeconds;
        _isLoading = false;
        notifyListeners();
      },
      failure: (message, code) {
        _errorMessage = message;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
