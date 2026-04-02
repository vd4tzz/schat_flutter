enum FriendshipStatus {
  none,
  pendingSent,
  pendingReceived,
  accepted,
  blockedByYou,
  blockedByThem;

  static FriendshipStatus fromString(String value) {
    return switch (value) {
      'PENDING_SENT' => pendingSent,
      'PENDING_RECEIVED' => pendingReceived,
      'ACCEPTED' => accepted,
      'BLOCKED_BY_YOU' => blockedByYou,
      'BLOCKED_BY_THEM' => blockedByThem,
      _ => none,
    };
  }
}

class FriendshipInfo {
  final FriendshipStatus status;
  final String? friendshipId;

  const FriendshipInfo({required this.status, this.friendshipId});

  factory FriendshipInfo.fromJson(Map<String, dynamic> json) {
    return FriendshipInfo(
      status: FriendshipStatus.fromString(json['status'] as String),
      friendshipId: json['friendshipId'] as String?,
    );
  }

  static const none = FriendshipInfo(status: FriendshipStatus.none);
}
