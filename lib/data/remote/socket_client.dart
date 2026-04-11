import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../core/constants/api_constants.dart';
import '../local/token_storage.dart';
import '../models/app_notification.dart';
import '../models/message.dart';

class SocketClient {
  final TokenStorage _tokenStorage;
  io.Socket? _socket;

  final _notificationController = StreamController<AppNotification>.broadcast();
  Stream<AppNotification> get notificationStream =>
      _notificationController.stream;

  final _messageSentController =
      StreamController<({Message message, String tempId})>.broadcast();
  Stream<({Message message, String tempId})> get messageSentStream =>
      _messageSentController.stream;

  final _newMessageController = StreamController<Message>.broadcast();
  Stream<Message> get newMessageStream => _newMessageController.stream;

  final _messageEditedController = StreamController<Message>.broadcast();
  Stream<Message> get messageEditedStream => _messageEditedController.stream;

  final _messageDeletedController =
      StreamController<({String conversationId, String messageId})>.broadcast();
  Stream<({String conversationId, String messageId})>
  get messageDeletedStream => _messageDeletedController.stream;

  final _reactionUpdatedController =
      StreamController<
        ({
          String conversationId,
          String messageId,
          String userId,
          String? emoji,
        })
      >.broadcast();
  Stream<
    ({String conversationId, String messageId, String userId, String? emoji})
  >
  get reactionUpdatedStream => _reactionUpdatedController.stream;

  final _readReceiptController =
      StreamController<
        ({String conversationId, String userId, int seq})
      >.broadcast();
  Stream<({String conversationId, String userId, int seq})>
  get readReceiptStream => _readReceiptController.stream;

  SocketClient(this._tokenStorage) {
    connect();
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

    _socket!.on('message_sent', (data) {
      try {
        final d = data as Map<String, dynamic>;

        _messageSentController.add((
          message: Message.fromJson(d['message'] as Map<String, dynamic>),
          tempId: d['tempId'] as String,
        ));
      } catch (_) {}
    });

    _socket!.on('new_message', (data) {
      try {
        final d = data as Map<String, dynamic>;

        _newMessageController.add(
          Message.fromJson(d['message'] as Map<String, dynamic>),
        );
      } catch (_) {}
    });

    _socket!.on('message_edited', (data) {
      try {
        final d = data as Map<String, dynamic>;

        _messageEditedController.add(
          Message.fromJson(d['message'] as Map<String, dynamic>),
        );
      } catch (_) {}
    });

    _socket!.on('message_deleted', (data) {
      try {
        final d = data as Map<String, dynamic>;

        _messageDeletedController.add((
          conversationId: d['conversationId'] as String,
          messageId: d['messageId'] as String,
        ));
      } catch (_) {}
    });

    _socket!.on('reaction_updated', (data) {
      try {
        final d = data as Map<String, dynamic>;

        _reactionUpdatedController.add((
          conversationId: d['conversationId'] as String,
          messageId: d['messageId'] as String,
          userId: d['userId'] as String,
          emoji: d['emoji'] as String?,
        ));
      } catch (_) {}
    });

    _socket!.on('read_receipt', (data) {
      try {
        final d = data as Map<String, dynamic>;

        _readReceiptController.add((
          conversationId: d['conversationId'] as String,
          userId: d['userId'] as String,
          seq: d['seq'] as int,
        ));
      } catch (_) {}
    });

    _socket!.connect();
  }

  // ----- Emit methods (Client → Server) ---------------------------------------

  void sendMessage({
    required String conversationId,
    required String content,
    required String tempId,
    String? replyToId,
    String type = 'TEXT',
  }) {
    _socket?.emit('send_message', {
      'conversationId': conversationId,
      'content': content,
      'tempId': tempId,
      'type': type,
      if (replyToId != null) 'replyToId': replyToId,
    });
  }

  void markRead(String conversationId, int seq) {
    _socket?.emit('mark_read', {'conversationId': conversationId, 'seq': seq});
  }

  void editMessage({
    required String conversationId,
    required String messageId,
    required String content,
  }) {
    _socket?.emit('edit_message', {
      'conversationId': conversationId,
      'messageId': messageId,
      'content': content,
    });
  }

  void deleteMessage({
    required String conversationId,
    required String messageId,
  }) {
    _socket?.emit('delete_message', {
      'conversationId': conversationId,
      'messageId': messageId,
    });
  }

  void reactMessage({
    required String conversationId,
    required String messageId,
    String? emoji,
  }) {
    _socket?.emit('react_message', {
      'conversationId': conversationId,
      'messageId': messageId,
      'emoji': emoji,
    });
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }

  void dispose() {
    disconnect();
    _notificationController.close();
    _messageSentController.close();
    _newMessageController.close();
    _messageEditedController.close();
    _messageDeletedController.close();
    _reactionUpdatedController.close();
    _readReceiptController.close();
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
