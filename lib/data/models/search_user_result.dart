import 'friendship_info.dart';
import 'user.dart';

class SearchUserResult {
  final User user;
  final FriendshipInfo friendship;

  const SearchUserResult({required this.user, required this.friendship});

  factory SearchUserResult.fromJson(Map<String, dynamic> json) {
    return SearchUserResult(
      user: User.fromJson(json),
      friendship: json['friendship'] != null
          ? FriendshipInfo.fromJson(json['friendship'] as Map<String, dynamic>)
          : FriendshipInfo.none,
    );
  }
}
