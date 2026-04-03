import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../core/constants/api_constants.dart';
import '../local/token_storage.dart';
import '../models/app_notification.dart';

class SocketClient {
  final TokenStorage _tokenStorage;
  io.Socket? _socket;

  final _notificationController = StreamController<AppNotification>.broadcast();
  Stream<AppNotification> get notificationStream =>
      _notificationController.stream;

  SocketClient(this._tokenStorage) {
    this.connect();
  }

  Future<void> connect() async {
    if (_socket != null && _socket!.connected) return;

    final token = await _tokenStorage.getAccessToken();
    if (token == null) return;

    _socket = io.io(
      ApiConstants.baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({'token': token})
          .enableForceNew()
          .build(),
    );

    _socket!.on('notification', (data) {
      final notification = _parseNotification(data as Map<String, dynamic>);
      if (notification != null) {
        _notificationController.add(notification);
      }
    });

    _socket!.connect();
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }

  void dispose() {
    disconnect();
    _notificationController.close();
  }

  AppNotification? _parseNotification(Map<String, dynamic> data) {
    try {
      return AppNotification(
        id: data['notificationId'] as String,
        type: AppNotificationType.fromString(data['type'] as String),
        payload: Map<String, dynamic>.from(data['payload'] as Map),
        isRead: false,
        createdAt: DateTime.parse(data['createdAt'] as String),
      );
    } catch (_) {
      return null;
    }
  }
}
