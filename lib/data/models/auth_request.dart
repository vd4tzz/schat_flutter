class RegisterRequest {
  final String fullName;
  final String username;
  final String email;
  final String password;

  RegisterRequest({
    required this.fullName,
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'username': username,
        'email': email,
        'password': password,
      };
}

class VerifyOtpRequest {
  final String email;
  final String otp;

  VerifyOtpRequest({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'otp': otp,
      };
}

class ResendOtpRequest {
  final String email;

  ResendOtpRequest({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

class LoginRequest {
  final String identifier;
  final String password;

  LoginRequest({
    required this.identifier,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'password': password,
      };
}

class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}
