import 'package:schat_flutter/core/utils/url_helper.dart';
import 'package:schat_flutter/data/local/app_database.dart';
import 'package:schat_flutter/data/models/participant.dart';

class LastMessage {
  final String id;
  final String? content;
  final String type;
  final int seq;
  final String senderId;
  final String senderName;
  final String? senderAvatarUrl;
  final bool isDeleted;
  final DateTime createdAt;

  LastMessage({
    required this.id,
    required this.content,
    required this.type,
    required this.seq,
    required this.senderId,
    required this.senderName,
    this.senderAvatarUrl,
    this.isDeleted = false,
    required this.createdAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    final sender = json['sender'] as Map<String, dynamic>;
    return LastMessage(
      id: json['id'] as String,
      content: json['content'] as String?,
      type: json['type'] as String,
      seq: int.parse(json['seq'].toString()),
      senderId: sender['id'] as String,
      senderName: sender['fullName'] as String,
      senderAvatarUrl: fixUrl(sender['avatarUrl'] as String?),
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
    );
  }
}

class Conversation {
  final String id;
  final String type;
  final String? name;
  final String? avatarUrl;
  final int lastSeq;
  final int lastReadSeq;
  final LastMessage? lastMessage;
  final List<Participant> participants;
  final DateTime updatedAt;
  final DateTime createdAt;

  Conversation({
    required this.id,
    required this.type,
    this.name,
    this.avatarUrl,
    required this.lastSeq,
    required this.lastReadSeq,
    this.lastMessage,
    this.participants = const [],
    required this.updatedAt,
    required this.createdAt,
  });

  int get unreadCount {
    final diff = lastSeq - lastReadSeq;
    return diff < 0 ? 0 : diff;
  }

  factory Conversation.fromJson(Map<String, dynamic> json, String myUserId) {
    final participants = (json['participants'] as List)
        .map((e) => Participant.fromJson(e as Map<String, dynamic>))
        .toList();
    final myParticipant = participants.firstWhere(
      (p) => p.userId == myUserId,
    );
    return Conversation(
      id: json['id'] as String,
      type: json['type'] as String,
      name: json['name'] as String?,
      avatarUrl: fixUrl(json['avatarUrl'] as String?),
      lastSeq: int.parse(json['lastSeq'].toString()),
      lastReadSeq: myParticipant.lastReadSeq,
      lastMessage: json['lastMessage'] != null
          ? LastMessage.fromJson(json['lastMessage'] as Map<String, dynamic>)
          : null,
      participants: participants,
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      createdAt: DateTime.parse(json['createdAt'] as String).toUtc(),
    );
  }

  factory Conversation.fromRow(
    CachedConversationTableData conv,
    CachedParticipantTableData p,
  ) {
    return Conversation(
      id: conv.id,
      type: conv.type,
      name: conv.name,
      avatarUrl: conv.avatarUrl,
      lastSeq: conv.lastSeq,
      lastReadSeq: p.lastReadSeq,
      lastMessage: conv.lastMessageId != null
          ? LastMessage(
              id: conv.lastMessageId!,
              content: conv.lastMessageContent,
              type: conv.lastMessageType!,
              seq: conv.lastSeq,
              senderId: conv.lastMessageSenderId!,
              senderName: conv.lastMessageSenderName!,
              isDeleted: conv.lastMessageIsDeleted,
              createdAt: DateTime.parse(conv.lastMessageCreatedAt!),
            )
          : null,
      updatedAt: DateTime.parse(conv.updatedAt),
      createdAt: DateTime.parse(conv.createdAt),
    );
  }
}
