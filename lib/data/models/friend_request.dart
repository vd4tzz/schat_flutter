class FriendRequest {
  final String id;
  final String requesterId;
  final String requesterName;
  final String requesterUsername;
  final String? requesterAvatarUrl;
  final DateTime createdAt;

  const FriendRequest({
    required this.id,
    required this.requesterId,
    required this.requesterName,
    required this.requesterUsername,
    this.requesterAvatarUrl,
    required this.createdAt,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    final requester = json['requester'] as Map<String, dynamic>;
    return FriendRequest(
      id: json['id'] as String,
      requesterId: requester['id'] as String,
      requesterName: requester['fullName'] as String,
      requesterUsername: requester['username'] as String,
      requesterAvatarUrl: requester['avatarUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
