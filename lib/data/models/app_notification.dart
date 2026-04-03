enum AppNotificationType {
  friendRequest,
  friendAccepted;

  static AppNotificationType fromString(String value) {
    return switch (value) {
      'FRIEND_REQUEST' => friendRequest,
      'FRIEND_ACCEPTED' => friendAccepted,
      _ => friendRequest,
    };
  }
}

class AppNotification {
  final String id;
  final AppNotificationType type;
  final Map<String, dynamic> payload;
  final bool isRead;
  final DateTime createdAt;

  const AppNotification({
    required this.id,
    required this.type,
    required this.payload,
    required this.isRead,
    required this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as String,
      type: AppNotificationType.fromString(json['type'] as String),
      payload: json['payload'] as Map<String, dynamic>,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Helpers for FRIEND_REQUEST payload
  String? get fromUserName => payload['fromUserName'] as String?;
  String? get fromUserAvatar => payload['fromUserAvatar'] as String?;
  String? get friendshipId => (payload['friendshipId'] ?? payload['byUserId'] != null
      ? payload['friendshipId']
      : null) as String?;

  // Helpers for FRIEND_ACCEPTED payload
  String? get byUserName => payload['byUserName'] as String?;
  String? get byUserAvatar => payload['byUserAvatar'] as String?;

  String get actorName => fromUserName ?? byUserName ?? '';
  String? get actorAvatar => fromUserAvatar ?? byUserAvatar;

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      type: type,
      payload: payload,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
    );
  }
}
