import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../data/models/friendship_info.dart';
import '../../../data/models/search_user_result.dart';
import '../../../data/repositories/friendship_repository.dart';
import '../../../data/repositories/user_repository.dart';

class InboxViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final FriendshipRepository _friendshipRepository;

  InboxViewModel(this._userRepository, this._friendshipRepository);

  List<SearchUserResult> _results = [];
  List<SearchUserResult> get results => _results;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String _query = '';
  Timer? _debounce;

  void onQueryChanged(String query) {
    _query = query.trim();
    _debounce?.cancel();

    if (_query.isEmpty) {
      _results = [];
      _error = null;
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _debounce = Timer(const Duration(milliseconds: 400), _search);
  }

  Future<void> _search() async {
    if (_query.isEmpty) return;

    final result = await _userRepository.searchUsers(_query);
    result.when(
      success: (data) {
        _results = data;
        _error = null;
      },
      failure: (message, _) {
        _error = message;
      },
    );
    _isLoading = false;
    notifyListeners();
  }

  Future<FriendshipInfo?> sendFriendRequest(String addresseeId) async {
    final result = await _friendshipRepository.sendRequest(addresseeId);
    return result.when(
      success: (info) {
        // Update friendship status in search results
        final index = _results.indexWhere((r) => r.user.id == addresseeId);
        if (index != -1) {
          _results[index] = SearchUserResult(
            user: _results[index].user,
            friendship: info,
          );
          notifyListeners();
        }
        return info;
      },
      failure: (message, _) {
        _error = message;
        notifyListeners();
        return null;
      },
    );
  }

  Future<bool> unfriend(String userId, String friendshipId) async {
    final result = await _friendshipRepository.unfriend(friendshipId);
    return result.when(
      success: (_) {
        final index = _results.indexWhere((r) => r.user.id == userId);
        if (index != -1) {
          _results[index] = SearchUserResult(
            user: _results[index].user,
            friendship: FriendshipInfo.none,
          );
          notifyListeners();
        }
        return true;
      },
      failure: (message, _) {
        _error = message;
        notifyListeners();
        return false;
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
