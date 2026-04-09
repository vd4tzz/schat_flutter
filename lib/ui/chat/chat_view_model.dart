import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/result/result.dart';
import '../../data/local/token_storage.dart';
import '../../data/models/message.dart';
import '../../data/models/participant.dart';
import '../../data/repositories/conversation_repository.dart';
import '../../data/repositories/message_repository.dart';
import '../../data/remote/socket_event_handler.dart';

class ChatViewModel extends ChangeNotifier {
  final MessageRepository _messageRepository;
  final ConversationRepository _conversationRepository;
  final SocketEventHandler _dispatcher;
  final String conversationId;

  String? _myUserId;
  String? get myUserId => _myUserId;

  // ─── Participants ─────────────────────────────────────────────────────────
  Map<String, Participant> _participants = {};

  Participant? getParticipant(String userId) => _participants[userId];

  String getSenderName(String userId) => _participants[userId]?.fullName ?? '';

  String? getSenderAvatarUrl(String userId) => _participants[userId]?.avatarUrl;

  // ─── Message lists ────────────────────────────────────────────────────────
  /// Newest-first (DESC) từ DB, tích lũy dần khi loadMore
  List<Message> _cachedMessages = [];

  /// Append order, chỉ tồn tại trong session hiện tại
  final List<Message> _realtimeMessages = [];

  /// Oldest-first list để render UI (reverse ListView)
  List<Message> get displayMessages => [
    ..._cachedMessages.reversed,
    ..._realtimeMessages,
  ];

  // ─── State ────────────────────────────────────────────────────────────────
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

  // ─── Subscriptions ────────────────────────────────────────────────────────
  StreamSubscription<({Message message, String tempId})>? _messageSentSub;

  StreamSubscription<Message>? _newMessageSub;

  StreamSubscription<Message>? _messageEditedSub;

  StreamSubscription<({String conversationId, String messageId})>?
  _messageDeletedSub;

  StreamSubscription<
    ({String conversationId, String messageId, String userId, String? emoji})
  >?
  _reactionUpdatedSub;

  ChatViewModel({
    required MessageRepository messageRepository,
    required ConversationRepository conversationRepository,
    required SocketEventHandler dispatcher,
    required this.conversationId,
  }) : _messageRepository = messageRepository,
       _conversationRepository = conversationRepository,
       _dispatcher = dispatcher {
    _subscribeToDispatcher();
    _init();
  }

  // ─── Init ─────────────────────────────────────────────────────────────────

  Future<void> _init() async {
    _participants = await _conversationRepository.getParticipants(
      conversationId,
    );

    _cachedMessages = await _messageRepository.getMessages(conversationId);

    _isLoading = false;
    notifyListeners();

    _myUserId = await TokenStorage.instance.getUserId();

    final Result<void> result;
    if (_cachedMessages.isNotEmpty) {
      result = await _messageRepository.syncNewMessages(
        conversationId,
        _cachedMessages.first.seq,
      );
    } else {
      result = await _messageRepository.fetchLatestMessages(conversationId);
    }

    result.when(
      success: (_) async {
        _cachedMessages = await _messageRepository.getMessages(conversationId);

        if (_cachedMessages.isNotEmpty) {
          final newMaxSeq = _cachedMessages.first.seq;
          _realtimeMessages.removeWhere((m) => m.seq <= newMaxSeq);
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

  // ─── Load More ────────────────────────────────────────────────────────────

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore || _cachedMessages.isEmpty) return;

    final oldestSeq = _cachedMessages.last.seq;
    _isLoadingMore = true;
    notifyListeners();

    final (older, hasMore) = await _messageRepository.loadMore(
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

  // ─── Actions ──────────────────────────────────────────────────────────────

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

    _dispatcher.sendMessage(
      conversationId: conversationId,
      content: content.trim(),
      tempId: tempId,
      replyToId: replyToId,
    );
  }

  void editMessage(String messageId, String newContent) {
    _dispatcher.editMessage(
      conversationId: conversationId,
      messageId: messageId,
      content: newContent,
    );
  }

  void deleteMessage(String messageId) {
    _dispatcher.deleteMessage(
      conversationId: conversationId,
      messageId: messageId,
    );
  }

  void reactMessage(String messageId, {String? emoji}) {
    _dispatcher.reactMessage(
      conversationId: conversationId,
      messageId: messageId,
      emoji: emoji,
    );
  }

  // ─── Dispatcher handlers ──────────────────────────────────────────────────

  void _subscribeToDispatcher() {
    _messageSentSub = _dispatcher.messageSentStream.listen(_onMessageSent);
    _newMessageSub = _dispatcher.newMessageStream.listen(_onNewMessage);
    _messageEditedSub = _dispatcher.messageEditedStream.listen(
      _onMessageEdited,
    );
    _messageDeletedSub = _dispatcher.messageDeletedStream.listen(
      _onMessageDeleted,
    );
    _reactionUpdatedSub = _dispatcher.reactionUpdatedStream.listen(
      _onReactionUpdated,
    );
  }

  void _onMessageSent(({Message message, String tempId}) event) async {
    _realtimeMessages.removeWhere((m) => m.id == event.tempId);
    _realtimeMessages.add(await _attachReplyTo(event.message));
    _isSending = false;
    notifyListeners();
  }

  void _onNewMessage(Message message) async {
    if (message.conversationId != conversationId) return;
    _realtimeMessages.add(await _attachReplyTo(message));
    _markRead();
    notifyListeners();
  }

  void _onMessageEdited(Message message) {
    if (message.conversationId != conversationId) return;
    _applyUpdate(
      message.id,
      (m) => message.copyWith(replyTo: m.replyTo),
    );
    notifyListeners();
  }

  void _onMessageDeleted(({String conversationId, String messageId}) event) {
    if (event.conversationId != conversationId) return;
    _applyUpdate(
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

    _applyUpdate(event.messageId, (m) {
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

  void _markRead() {
    if (_myUserId == null) return;
    _dispatcher.markRead(conversationId);
    _conversationRepository.markReadLocally(conversationId, _myUserId!);
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

  void _applyUpdate(String messageId, Message Function(Message) transform) {
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
    print('ChatViewModel[$conversationId] disposed');
    _messageSentSub?.cancel();
    _newMessageSub?.cancel();
    _messageEditedSub?.cancel();
    _messageDeletedSub?.cancel();
    _reactionUpdatedSub?.cancel();
    super.dispose();
  }
}
