import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../data/models/app_notification.dart';
import '../../../data/models/friend_request.dart';
import '../../../data/remote/socket_event_handler.dart';
import '../../../data/repositories/friendship_repository.dart';
import '../../../data/repositories/notification_repository.dart';

class NotificationsViewModel extends ChangeNotifier {
  final NotificationRepository _notificationRepository;
  final FriendshipRepository _friendshipRepository;
  StreamSubscription? _socketSub;
  StreamSubscription? _dbSub;

  NotificationsViewModel(
    this._notificationRepository,
    this._friendshipRepository,
    SocketEventHandler dispatcher,
  ) {
    // Dispatcher đã persist notification vào DB, chỉ cần trigger UI reload
    _socketSub = dispatcher.notificationStream.listen((_) {});

    _dbSub = _notificationRepository.watch().listen((data) {
      _notifications = data;
      _unreadCount = data.where((n) => !n.isRead).length;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _socketSub?.cancel();
    _dbSub?.cancel();
    super.dispose();
  }

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

    final result = await _notificationRepository.refresh();
    result.when(success: (_) {}, failure: (msg, _) => _error = msg);

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
    if (_notifications.any((n) => n.id == id && n.isRead)) return;
    await _notificationRepository.markAsRead(id);
  }

  Future<void> markAllAsRead() async {
    await _notificationRepository.markAllAsRead();
  }

  Future<void> deleteNotification(String id) async {
    await _notificationRepository.delete(id);
  }

  Future<bool> acceptRequest(String friendshipId) async {
    final result = await _friendshipRepository.acceptRequest(friendshipId);
    return result.when(
      success: (_) {
        _incomingRequests = _incomingRequests
            .where((r) => r.id != friendshipId)
            .toList();
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
        _incomingRequests = _incomingRequests
            .where((r) => r.id != friendshipId)
            .toList();
        notifyListeners();
        return true;
      },
      failure: (msg, code) => false,
    );
  }
}
