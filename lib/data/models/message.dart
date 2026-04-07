import 'dart:convert';

import 'package:drift/drift.dart' as drift show Value;
import 'package:schat_flutter/data/local/app_database.dart';

enum MessageType {
  text,
  image,
  file,
  video,
  audio,
  system,
  call;

  static MessageType fromString(String s) {
    return MessageType.values.firstWhere(
      (e) => e.name.toUpperCase() == s.toUpperCase(),
      orElse: () => MessageType.text,
    );
  }

  String toApiString() => name.toUpperCase();
}

class MessageReaction {
  final String messageId;
  final String userId;
  final String emoji;

  const MessageReaction({
    required this.messageId,
    required this.userId,
    required this.emoji,
  });

  factory MessageReaction.fromJson(Map<String, dynamic> json) {
    return MessageReaction(
      messageId: json['messageId'] as String,
      userId: json['userId'] as String,
      emoji: json['emoji'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'messageId': messageId,
    'userId': userId,
    'emoji': emoji,
  };
}

class Message {
  final String id;
  final String conversationId;
  final int seq;
  final String? content;
  final MessageType type;
  final String senderId;
  final bool isEdited;
  final bool isDeleted;
  final List<MessageReaction> reactions;
  final String? replyToId;
  final Message? replyTo;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.conversationId,
    required this.seq,
    this.content,
    required this.type,
    required this.senderId,
    required this.isEdited,
    required this.isDeleted,
    required this.reactions,
    this.replyToId,
    this.replyTo,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      seq: int.parse(json['seq'].toString()),
      content: json['content'] as String?,
      type: MessageType.fromString(json['type'] as String? ?? 'TEXT'),
      senderId: json['senderId'] as String,
      isEdited: json['isEdited'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      reactions: (json['reactions'] as List? ?? [])
          .map((e) => MessageReaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      replyToId: json['replyToId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
    );
  }

  factory Message.optimistic({
    required String tempId,
    required String conversationId,
    required String content,
    required String senderId,
    String? replyToId,
  }) {
    return Message(
      id: tempId,
      conversationId: conversationId,
      seq: -1,
      content: content,
      type: MessageType.text,
      senderId: senderId,
      isEdited: false,
      isDeleted: false,
      reactions: [],
      replyToId: replyToId,
      createdAt: DateTime.now().toUtc(),
    );
  }

  Message copyWith({
    String? content,
    bool? isEdited,
    bool? isDeleted,
    List<MessageReaction>? reactions,
    Message? replyTo,
  }) {
    return Message(
      id: id,
      conversationId: conversationId,
      seq: seq,
      content: content ?? this.content,
      type: type,
      senderId: senderId,
      isEdited: isEdited ?? this.isEdited,
      isDeleted: isDeleted ?? this.isDeleted,
      reactions: reactions ?? this.reactions,
      replyToId: replyToId,
      replyTo: replyTo ?? this.replyTo,
      createdAt: createdAt,
    );
  }

  factory Message.fromRow(CachedMessageTableData row) {
    final reactionsRaw = jsonDecode(row.reactionsJson) as List<dynamic>;

    return Message(
      id: row.id,
      conversationId: row.conversationId,
      seq: row.seq,
      content: row.content,
      type: MessageType.fromString(row.type),
      senderId: row.senderId,
      isEdited: row.isEdited,
      isDeleted: row.isDeleted,
      reactions: reactionsRaw
          .map((e) => MessageReaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      replyToId: row.replyToId,
      createdAt: DateTime.parse(row.createdAt).toUtc(),
    );
  }

  CachedMessageTableCompanion toCompanion() {
    return CachedMessageTableCompanion.insert(
      id: id,
      conversationId: conversationId,
      seq: seq,
      content: drift.Value(content),
      type: type.toApiString(),
      senderId: senderId,
      reactionsJson: drift.Value(
        jsonEncode(reactions.map((r) => r.toJson()).toList()),
      ),
      replyToId: drift.Value(replyToId),
      createdAt: createdAt.toIso8601String(),
    );
  }
}
