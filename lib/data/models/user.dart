import 'dart:io' show Platform;

class User {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String? bio;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? avatarUrl;
  final String? backgroundUrl;

  static String? _fixUrl(String? url) {
    if (url == null) return null;
    if (Platform.isAndroid && url.contains('localhost')) {
      return url.replaceAll('localhost', '10.0.2.2');
    }
    return url;
  }

  User({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    this.bio,
    this.gender,
    this.dateOfBirth,
    this.phoneNumber,
    this.avatarUrl,
    this.backgroundUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      phoneNumber: json['phoneNumber'] as String?,
      avatarUrl: _fixUrl(json['avatarUrl'] as String?),
      backgroundUrl: _fixUrl(json['backgroundUrl'] as String?),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'username': username,
        'email': email,
        'bio': bio,
        'gender': gender,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'phoneNumber': phoneNumber,
        'avatarUrl': avatarUrl,
        'backgroundUrl': backgroundUrl,
      };
}
