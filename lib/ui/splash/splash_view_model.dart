import 'package:flutter/foundation.dart';
import '../../data/repositories/auth_repository.dart';

enum SplashState { loading, authenticated, unauthenticated }

class SplashViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  SplashViewModel(this._authRepository);

  SplashState _state = SplashState.loading;
  SplashState get state => _state;

  Future<bool> isLoggedIn() async {
    final isLoggedIn = await _authRepository.isLoggedIn();
    _state = isLoggedIn
        ? SplashState.authenticated
        : SplashState.unauthenticated;
    notifyListeners();
    return isLoggedIn;
  }
}
