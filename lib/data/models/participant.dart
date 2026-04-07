import 'package:schat_flutter/core/utils/url_helper.dart';

class Participant {
  final String userId;
  final String fullName;
  final String? avatarUrl;
  final String role;
  final int lastReadSeq;
  final DateTime? leftAt;

  Participant({
    required this.userId,
    required this.fullName,
    this.avatarUrl,
    required this.role,
    required this.lastReadSeq,
    this.leftAt,
  });

  bool get hasLeft => leftAt != null;

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      userId: json['id'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: fixUrl(json['avatarUrl'] as String?),
      role: json['role'] as String,
      lastReadSeq: int.parse(json['lastReadSeq'].toString()),
      leftAt: json['leftAt'] != null
          ? DateTime.parse(json['leftAt'] as String).toUtc()
          : null,
    );
  }
}
