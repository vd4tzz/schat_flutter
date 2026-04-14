import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../data/local/token_storage.dart';
import '../../data/models/message.dart';
import '../../data/models/participant.dart';
import '../../data/repositories/conversation_repository.dart';
import '../../data/repositories/message_repository.dart';
import '../../data/remote/socket_event_handler.dart';

class ChatViewModel extends ChangeNotifier {
  final MessageRepository _messageRepository;
  final ConversationRepository _conversationRepository;
  final SocketEventHandler _eventHandler;
  final String conversationId;

  String? _myUserId;
  String? get myUserId => _myUserId;

  Map<String, Participant> _participants = {};

  String getSenderName(String userId) => _participants[userId]?.fullName ?? '';

  String? getSenderAvatarUrl(String userId) => _participants[userId]?.avatarUrl;

  // ─── Message lists ────────────────────────────────────────────────────────
  /// Newest-first (DESC) from DB, accumulated by loadMore
  List<Message> _cachedMessages = [];

  /// Append order, only exists in current session
  final List<Message> _realtimeMessages = [];

  /// Oldest-first list for UI rendering (reverse ListView)
  List<Message> get messages => [
    ..._cachedMessages.reversed,
    ..._realtimeMessages,
  ];

  // ----- State -------------------------------------------------------------
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  bool _isSending = false;
  bool get isSending => _isSending;

  String? _error;
  String? get error => _error;
  // -------------------------------------------------------------------------

  // ----- Subscriptions -----------------------------------------------------
  StreamSubscription<({Message message, String tempId})>? _messageSentSub;

  StreamSubscription<Message>? _newMessageSub;

  StreamSubscription<Message>? _messageEditedSub;

  StreamSubscription<({String conversationId, String messageId})>?
  _messageDeletedSub;

  StreamSubscription<
    ({String conversationId, String messageId, String userId, String? emoji})
  >?
  _reactionUpdatedSub;

  StreamSubscription<({String conversationId, String userId, int seq})>?
  _readReceiptSub;
  // -------------------------------------------------------------------------

  ChatViewModel({
    required MessageRepository messageRepository,
    required ConversationRepository conversationRepository,
    required SocketEventHandler dispatcher,
    required this.conversationId,
  }) : _messageRepository = messageRepository,
       _conversationRepository = conversationRepository,
       _eventHandler = dispatcher {
    _subscribeToDispatcher();
    _init();
  }

  Future<void> _init() async {
    _myUserId = await TokenStorage.instance.getUserId();

    _participants = await _conversationRepository.getCachedParticipants(
      conversationId,
    );

    _cachedMessages = await _messageRepository.getCachedMessages(
      conversationId,
    );

    _isLoading = false;
    notifyListeners();

    final result = await _messageRepository.syncAndGetMessages(conversationId);

    result.when(
      success: (messages) {
        _cachedMessages = messages;
        if (messages.isNotEmpty) {
          _realtimeMessages.removeWhere((m) => m.seq <= messages.first.seq);
        }
        notifyListeners();
      },
      failure: (msg, _) {
        _error = msg;
        notifyListeners();
      },
    );

    _markRead();
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore || _cachedMessages.isEmpty) return;

    final oldestSeq = _cachedMessages.last.seq;
    _isLoadingMore = true;
    notifyListeners();

    final (older, hasMore) = await _messageRepository.loadMoreMessages(
      conversationId,
      oldestSeq,
    );

    _hasMore = hasMore;
    if (older.isNotEmpty) {
      _cachedMessages = [..._cachedMessages, ...older];
    }
    _isLoadingMore = false;
    notifyListeners();
  }

  void sendMessage(String content, {String? replyToId}) {
    if (content.trim().isEmpty) return;

    final tempId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
    final optimistic = Message.optimistic(
      tempId: tempId,
      conversationId: conversationId,
      content: content.trim(),
      senderId: _myUserId ?? '',
      replyToId: replyToId,
    );

    _realtimeMessages.add(optimistic);
    _isSending = true;
    notifyListeners();

    _eventHandler.sendMessage(
      conversationId: conversationId,
      content: content.trim(),
      tempId: tempId,
      replyToId: replyToId,
    );
  }

  void editMessage(String messageId, String newContent) {
    _eventHandler.editMessage(messageId: messageId, content: newContent);
  }

  void deleteMessage(String messageId) {
    _eventHandler.deleteMessage(
      conversationId: conversationId,
      messageId: messageId,
    );
  }

  void reactMessage(String messageId, {String? emoji}) {
    _eventHandler.reactMessage(
      conversationId: conversationId,
      messageId: messageId,
      emoji: emoji,
    );
  }

  void _subscribeToDispatcher() {
    _messageSentSub = _eventHandler.messageSentStream.listen(_onMessageSent);
    _newMessageSub = _eventHandler.newMessageStream.listen(_onNewMessage);
    _messageEditedSub = _eventHandler.messageEditedStream.listen(
      _onMessageEdited,
    );
    _messageDeletedSub = _eventHandler.messageDeletedStream.listen(
      _onMessageDeleted,
    );
    _reactionUpdatedSub = _eventHandler.reactionUpdatedStream.listen(
      _onReactionUpdated,
    );
    _readReceiptSub = _eventHandler.readReceiptStream.listen(_onReadReceipt);
  }

  void _onMessageSent(({Message message, String tempId}) event) async {
    var found = false;
    for (var i = 0; i < _realtimeMessages.length; i++) {
      if (_realtimeMessages[i].id == event.tempId) {
        _realtimeMessages.removeAt(i);
        found = true;
        break;
      }
    }
    _realtimeMessages.add(await _attachReplyTo(event.message));
    if (found) _isSending = false;
    notifyListeners();
  }

  void _onNewMessage(Message message) async {
    if (message.conversationId != conversationId) return;
    _realtimeMessages.add(await _attachReplyTo(message));
    _markRead();
    notifyListeners();
  }

  void _onMessageEdited(Message editedMessage) {
    if (editedMessage.conversationId != conversationId) return;
    _updateMessage(
      editedMessage.id,
      (m) => editedMessage.copyWith(replyTo: m.replyTo, reactions: m.reactions),
    );
    notifyListeners();
  }

  void _onMessageDeleted(({String conversationId, String messageId}) event) {
    if (event.conversationId != conversationId) return;
    _updateMessage(
      event.messageId,
      (m) => m.copyWith(isDeleted: true, content: null),
    );
    notifyListeners();
  }

  void _onReactionUpdated(
    ({String conversationId, String messageId, String userId, String? emoji})
    event,
  ) {
    if (event.conversationId != conversationId) return;

    _updateMessage(event.messageId, (m) {
      final reactions = List<MessageReaction>.from(m.reactions)
        ..removeWhere((r) => r.userId == event.userId);
      if (event.emoji != null) {
        reactions.add(
          MessageReaction(
            messageId: event.messageId,
            userId: event.userId,
            emoji: event.emoji!,
          ),
        );
      }
      return m.copyWith(reactions: reactions);
    });
    notifyListeners();
  }

  void _onReadReceipt(
    ({String conversationId, String userId, int seq}) event,
  ) async {
    if (event.conversationId != conversationId) return;
    _participants = await _conversationRepository.getCachedParticipants(
      conversationId,
    );
    notifyListeners();
  }

  void _markRead() {
    if (_myUserId == null) return;

    final seq = _latestSeq;
    if (seq == null) return;

    _eventHandler.markRead(conversationId, seq);
    _conversationRepository.markRead(conversationId, _myUserId!, seq);
  }

  int? get _latestSeq {
    final cachedSeq = _cachedMessages.isNotEmpty
        ? _cachedMessages.first.seq
        : null;
    final realtimeSeq = _realtimeMessages.isNotEmpty
        ? _realtimeMessages.last.seq
        : null;

    if (cachedSeq == null) return realtimeSeq;
    if (realtimeSeq == null) return cachedSeq;
    return cachedSeq > realtimeSeq ? cachedSeq : realtimeSeq;
  }

  Future<Message> _attachReplyTo(Message message) async {
    if (message.replyToId == null) return message;

    final allMessages = [..._cachedMessages, ..._realtimeMessages];

    var reply = allMessages.cast<Message?>().firstWhere(
      (m) => m!.id == message.replyToId,
      orElse: () => null,
    );
    if (reply != null) return message.copyWith(replyTo: reply);

    reply = await _messageRepository.getMessage(message.replyToId!);
    if (reply != null) return message.copyWith(replyTo: reply);

    return message;
  }

  void _updateMessage(String messageId, Message Function(Message) transform) {
    for (var i = 0; i < _cachedMessages.length; i++) {
      if (_cachedMessages[i].id == messageId) {
        _cachedMessages[i] = transform(_cachedMessages[i]);
      } else if (_cachedMessages[i].replyTo?.id == messageId) {
        _cachedMessages[i] = _cachedMessages[i].copyWith(
          replyTo: transform(_cachedMessages[i].replyTo!),
        );
      }
    }

    for (var i = 0; i < _realtimeMessages.length; i++) {
      if (_realtimeMessages[i].id == messageId) {
        _realtimeMessages[i] = transform(_realtimeMessages[i]);
      } else if (_realtimeMessages[i].replyTo?.id == messageId) {
        _realtimeMessages[i] = _realtimeMessages[i].copyWith(
          replyTo: transform(_realtimeMessages[i].replyTo!),
        );
      }
    }
  }

  @override
  void dispose() {
    _messageSentSub?.cancel();
    _newMessageSub?.cancel();
    _messageEditedSub?.cancel();
    _messageDeletedSub?.cancel();
    _reactionUpdatedSub?.cancel();
    _readReceiptSub?.cancel();
    super.dispose();
  }
}
