class RegisterResponse {
  final int otpExpiresIn;

  RegisterResponse({required this.otpExpiresIn});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      otpExpiresIn: json['otpExpiresIn'] as int,
    );
  }
}

class UserInfo {
  final String id;
  final String fullName;
  final String username;
  final String email;

  UserInfo({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }
}

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final UserInfo user;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class RefreshResponse {
  final String accessToken;
  final String refreshToken;

  RefreshResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RefreshResponse.fromJson(Map<String, dynamic> json) {
    return RefreshResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}
