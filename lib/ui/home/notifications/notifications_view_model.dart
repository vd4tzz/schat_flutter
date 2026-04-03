import 'package:flutter/foundation.dart';

import '../../../data/models/app_notification.dart';
import '../../../data/models/friend_request.dart';
import '../../../data/repositories/friendship_repository.dart';
import '../../../data/repositories/notification_repository.dart';

class NotificationsViewModel extends ChangeNotifier {
  final NotificationRepository _notificationRepository;
  final FriendshipRepository _friendshipRepository;

  NotificationsViewModel(
    this._notificationRepository,
    this._friendshipRepository,
  );

  List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;

  List<FriendRequest> _incomingRequests = [];
  List<FriendRequest> get incomingRequests => _incomingRequests;

  int _unreadCount = 0;
  int get unreadCount => _unreadCount;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isRequestsLoading = false;
  bool get isRequestsLoading => _isRequestsLoading;

  String? _error;
  String? get error => _error;

  Future<void> loadNotifications() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _notificationRepository.list();
    result.when(
      success: (data) {
        _notifications = data;
        _unreadCount = data.where((n) => !n.isRead).length;
      },
      failure: (msg, _) => _error = msg,
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadIncomingRequests() async {
    _isRequestsLoading = true;
    notifyListeners();

    final result = await _friendshipRepository.listIncomingRequests();
    result.when(
      success: (data) => _incomingRequests = data,
      failure: (msg, _) {},
    );

    _isRequestsLoading = false;
    notifyListeners();
  }

  Future<void> markAsRead(String id) async {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index == -1 || _notifications[index].isRead) return;

    _notifications[index] = _notifications[index].copyWith(isRead: true);
    _unreadCount = (_unreadCount - 1).clamp(0, _unreadCount);
    notifyListeners();

    await _notificationRepository.markAsRead(id);
  }

  Future<void> markAllAsRead() async {
    _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
    _unreadCount = 0;
    notifyListeners();

    await _notificationRepository.markAllAsRead();
  }

  Future<void> deleteNotification(String id) async {
    final removed = _notifications.firstWhere(
      (n) => n.id == id,
      orElse: () => _notifications.first,
    );
    _notifications = _notifications.where((n) => n.id != id).toList();
    if (!removed.isRead) {
      _unreadCount = (_unreadCount - 1).clamp(0, _unreadCount);
    }
    notifyListeners();

    await _notificationRepository.delete(id);
  }

  Future<bool> acceptRequest(String friendshipId) async {
    final result = await _friendshipRepository.acceptRequest(friendshipId);
    return result.when(
      success: (_) {
        _incomingRequests =
            _incomingRequests.where((r) => r.id != friendshipId).toList();
        notifyListeners();
        return true;
      },
      failure: (msg, code) => false,
    );
  }

  Future<bool> rejectRequest(String friendshipId) async {
    final result = await _friendshipRepository.rejectRequest(friendshipId);
    return result.when(
      success: (_) {
        _incomingRequests =
            _incomingRequests.where((r) => r.id != friendshipId).toList();
        notifyListeners();
        return true;
      },
      failure: (msg, code) => false,
    );
  }
}
