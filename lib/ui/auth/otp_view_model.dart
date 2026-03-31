import 'package:flutter/foundation.dart';
import '../../data/repositories/auth_repository.dart';

class OtpViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  VoidCallback? _onVerifySuccess;

  OtpViewModel(this._authRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setOnVerifySuccess(VoidCallback callback) {
    _onVerifySuccess = callback;
  }

  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _authRepository.verifyOtp(email: email, otp: otp);

    result.when(
      success: (_) {
        _isLoading = false;
        notifyListeners();
        _onVerifySuccess?.call();
      },
      failure: (message, code) {
        _errorMessage = message;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> resendOtp({required String email}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _authRepository.resendOtp(email: email);

    result.when(
      success: (_) {
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
