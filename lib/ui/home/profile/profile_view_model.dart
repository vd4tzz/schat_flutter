import 'package:flutter/foundation.dart';

import '../../../data/models/user.dart';
import '../../../data/repositories/user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  ProfileViewModel(this._userRepository);

  User? _user;
  User? get user => _user;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isUploading = false;
  bool get isUploading => _isUploading;

  String? _error;
  String? get error => _error;

  Future<void> loadProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _userRepository.getProfile();
    result.when(
      success: (user) {
        _user = user;
        _isLoading = false;
        _error = null;
      },
      failure: (message, code) {
        _user = null;
        _isLoading = false;
        _error = message;
      },
    );
    notifyListeners();
  }

  Future<void> uploadAvatar(String filePath) async {
    _isUploading = true;
    _error = null;
    notifyListeners();

    final result = await _userRepository.uploadAvatar(filePath);
    result.when(
      success: (user) {
        _user = user;
        _isUploading = false;
        _error = null;
      },
      failure: (message, code) {
        _isUploading = false;
        _error = message;
      },
    );
    notifyListeners();
  }

  Future<void> uploadBackground(String filePath) async {
    _isUploading = true;
    _error = null;
    notifyListeners();

    final result = await _userRepository.uploadBackground(filePath);
    result.when(
      success: (user) {
        _user = user;
        _isUploading = false;
        _error = null;
      },
      failure: (message, code) {
        _isUploading = false;
        _error = message;
      },
    );
    notifyListeners();
  }

  Future<void> deleteAvatar() async {
    _isUploading = true;
    _error = null;
    notifyListeners();

    final result = await _userRepository.deleteAvatar();
    result.when(
      success: (user) {
        _user = user;
        _isUploading = false;
        _error = null;
      },
      failure: (message, code) {
        _isUploading = false;
        _error = message;
      },
    );
    notifyListeners();
  }

  Future<void> deleteBackground() async {
    _isUploading = true;
    _error = null;
    notifyListeners();

    final result = await _userRepository.deleteBackground();
    result.when(
      success: (user) {
        _user = user;
        _isUploading = false;
        _error = null;
      },
      failure: (message, code) {
        _isUploading = false;
        _error = message;
      },
    );
    notifyListeners();
  }

  Future<void> updateProfile({
    String? fullName,
    String? bio,
    String? gender,
    DateTime? dateOfBirth,
    String? phoneNumber,
  }) async {
    _isUploading = true;
    _error = null;
    notifyListeners();

    final result = await _userRepository.updateProfile(
      fullName: fullName,
      bio: bio,
      gender: gender,
      dateOfBirth: dateOfBirth,
      phoneNumber: phoneNumber,
    );
    result.when(
      success: (user) {
        _user = user;
        _isUploading = false;
        _error = null;
      },
      failure: (message, code) {
        _isUploading = false;
        _error = message;
      },
    );
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
