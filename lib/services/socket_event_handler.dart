import 'dart:async';

import '../data/models/app_notification.dart';
import '../data/models/message.dart';
import '../data/repositories/conversation_repository.dart';
import '../data/repositories/message_repository.dart';
import '../data/repositories/notification_repository.dart';
import '../data/remote/socket_client.dart';
import '../data/models/socket_events.dart';

/// Nhận toàn bộ socket events từ [SocketClient], persist vào repository,
/// rồi re-expose streams cho các ViewModel subscribe.
class SocketEventHandler {
  final SocketClient _socketClient;
  final MessageRepository _messageRepository;
  final ConversationRepository _conversationRepository;
  final NotificationRepository _notificationRepository;

  // --- Re-exposed streams ---------------------------------------------------
  final _newMessageController = StreamController<Message>.broadcast();
  final _messageSentController = StreamController<MessageSentEvent>.broadcast();
  final _messageEditedController = StreamController<Message>.broadcast();
  final _messageDeletedController =
      StreamController<MessageDeletedEvent>.broadcast();
  final _reactionUpdatedController =
      StreamController<ReactionUpdatedEvent>.broadcast();
  final _readReceiptController = StreamController<ReadReceiptEvent>.broadcast();
  final _notificationController = StreamController<AppNotification>.broadcast();

  Stream<Message> get newMessageStream => _newMessageController.stream;
  Stream<MessageSentEvent> get messageSentStream =>
      _messageSentController.stream;
  Stream<Message> get messageEditedStream => _messageEditedController.stream;
  Stream<MessageDeletedEvent> get messageDeletedStream =>
      _messageDeletedController.stream;
  Stream<ReactionUpdatedEvent> get reactionUpdatedStream =>
      _reactionUpdatedController.stream;
  Stream<ReadReceiptEvent> get readReceiptStream =>
      _readReceiptController.stream;
  Stream<AppNotification> get notificationStream =>
      _notificationController.stream;

  // --- Subscriptions tới SocketClient ---------------------------------------
  StreamSubscription<Message>? _newMessageSub;
  StreamSubscription<MessageSentEvent>? _messageSentSub;
  StreamSubscription<Message>? _messageEditedSub;
  StreamSubscription<MessageDeletedEvent>? _messageDeletedSub;
  StreamSubscription<ReactionUpdatedEvent>? _reactionUpdatedSub;
  StreamSubscription<ReadReceiptEvent>? _readReceiptSub;
  StreamSubscription<AppNotification>? _notificationSub;

  SocketEventHandler(
    this._socketClient,
    this._messageRepository,
    this._conversationRepository,
    this._notificationRepository,
  ) {
    _init();
  }

  void _init() {
    _newMessageSub = _socketClient.newMessageStream.listen(_onNewMessage);
    _messageSentSub = _socketClient.messageSentStream.listen(_onMessageSent);
    _messageEditedSub = _socketClient.messageEditedStream.listen(
      _onMessageEdited,
    );
    _messageDeletedSub = _socketClient.messageDeletedStream.listen(
      _onMessageDeleted,
    );
    _reactionUpdatedSub = _socketClient.reactionUpdatedStream.listen(
      _onReactionUpdated,
    );
    _readReceiptSub = _socketClient.readReceiptStream.listen(_onReadReceipt);
    _notificationSub = _socketClient.notificationStream.listen(_onNotification);
  }

  // --- Handlers methods -----------------------------------------------------

  void _onNewMessage(Message message) async {
    await _conversationRepository.updateLastMessage(message);
    _messageRepository.upsertMessage(message);
    _conversationRepository.updateSenderLastReadSeq(message);
    _newMessageController.add(message);
  }

  void _onMessageSent(MessageSentEvent event) {
    _messageRepository.upsertMessage(event.message);
    _conversationRepository.updateLastMessage(event.message);
    _conversationRepository.updateSenderLastReadSeq(event.message);
    _messageSentController.add(event);
  }

  void _onMessageEdited(Message message) {
    _messageRepository.updateMessageContent(message.id, message.content ?? '');
    _conversationRepository.updateLastMessage(message);
    _messageEditedController.add(message);
  }

  void _onMessageDeleted(MessageDeletedEvent event) {
    _messageRepository.markMessageDeleted(event.messageId);
    _messageDeletedController.add(event);
  }

  void _onReactionUpdated(ReactionUpdatedEvent event) {
    _messageRepository.updateMessageReaction(
      event.messageId,
      event.userId,
      event.emoji,
    );
    _reactionUpdatedController.add(event);
  }

  void _onReadReceipt(ReadReceiptEvent event) {
    _conversationRepository.markRead(
      event.conversationId,
      event.userId,
      event.seq,
    );
    _readReceiptController.add(event);
  }

  void _onNotification(AppNotification notification) {
    _notificationRepository.insertNotification(notification);
    _notificationController.add(notification);
  }

  // --- Emit methods ---------------------------------------------------------

  void sendMessage({
    required String conversationId,
    required String content,
    required String tempId,
    String? replyToId,
    String type = 'TEXT',
  }) {
    _socketClient.sendMessage(
      conversationId: conversationId,
      content: content,
      tempId: tempId,
      replyToId: replyToId,
      type: type,
    );
  }

  void markRead(String conversationId, int seq) {
    _socketClient.markRead(conversationId, seq);
  }

  void editMessage({
    required String conversationId,
    required String messageId,
    required String content,
  }) {
    _socketClient.editMessage(
      conversationId: conversationId,
      messageId: messageId,
      content: content,
    );
  }

  void deleteMessage({
    required String conversationId,
    required String messageId,
  }) {
    _socketClient.deleteMessage(
      conversationId: conversationId,
      messageId: messageId,
    );
  }

  void reactMessage({
    required String conversationId,
    required String messageId,
    String? emoji,
  }) {
    _socketClient.reactMessage(
      conversationId: conversationId,
      messageId: messageId,
      emoji: emoji,
    );
  }

  void dispose() {
    _newMessageSub?.cancel();
    _messageSentSub?.cancel();
    _messageEditedSub?.cancel();
    _messageDeletedSub?.cancel();
    _reactionUpdatedSub?.cancel();
    _readReceiptSub?.cancel();
    _notificationSub?.cancel();
    _readReceiptController.close();
    _newMessageController.close();
    _messageSentController.close();
    _messageEditedController.close();
    _messageDeletedController.close();
    _reactionUpdatedController.close();
    _notificationController.close();
  }
}
