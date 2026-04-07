import 'package:flutter/material.dart';

import '../../../data/models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final String senderName;
  final String? senderAvatarUrl;
  final String? replySenderName;
  final VoidCallback? onLongPress;
  final VoidCallback? onReply;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.senderName,
    this.senderAvatarUrl,
    this.replySenderName,
    this.onLongPress,
    this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOptimistic = message.seq == -1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 14,
              backgroundImage: senderAvatarUrl != null
                  ? NetworkImage(senderAvatarUrl!)
                  : null,
              child: senderAvatarUrl == null
                  ? Text(
                      senderName.isNotEmpty
                          ? senderName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(fontSize: 12),
                    )
                  : null,
            ),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: GestureDetector(
              onLongPress: onLongPress,
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  _BubbleContent(
                    message: message,
                    isMe: isMe,
                    isOptimistic: isOptimistic,
                    replySenderName: replySenderName,
                    theme: theme,
                  ),
                  if (message.reactions.isNotEmpty)
                    _ReactionsRow(reactions: message.reactions),
                ],
              ),
            ),
          ),
          if (isOptimistic) ...[
            const SizedBox(width: 4),
            const Icon(Icons.access_time, size: 12, color: Colors.grey),
          ],
        ],
      ),
    );
  }
}

class _BubbleContent extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool isOptimistic;
  final String? replySenderName;
  final ThemeData theme;

  const _BubbleContent({
    required this.message,
    required this.isMe,
    required this.isOptimistic,
    this.replySenderName,
    required this.theme,
  });

  static String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = isMe
        ? theme.colorScheme.primary
        : theme.colorScheme.surfaceContainerHighest;
    final textColor = isMe
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurface;

    return Opacity(
      opacity: isOptimistic ? 0.6 : 1.0,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.replyTo != null)
              _ReplyToBox(
                replyTo: message.replyTo!,
                senderName: replySenderName ?? '',
                textColor: textColor,
              ),
            if (message.isDeleted)
              Text(
                'Tin nhắn đã bị xóa',
                style: TextStyle(
                  color: textColor.withValues(alpha: 0.6),
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              )
            else
              Text(
                message.content ?? '',
                style: TextStyle(color: textColor, fontSize: 15),
              ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(message.createdAt.toLocal()),
                  style: TextStyle(
                    color: textColor.withValues(alpha: 0.6),
                    fontSize: 11,
                  ),
                ),
                if (message.isEdited && !message.isDeleted) ...[
                  const SizedBox(width: 4),
                  Text(
                    'đã sửa',
                    style: TextStyle(
                      color: textColor.withValues(alpha: 0.6),
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ReplyToBox extends StatelessWidget {
  final Message replyTo;
  final String senderName;
  final Color textColor;

  const _ReplyToBox({
    required this.replyTo,
    required this.senderName,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: textColor.withValues(alpha: 0.5),
            width: 3,
          ),
        ),
        color: textColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            senderName,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            replyTo.isDeleted
                ? 'Tin nhắn đã bị xóa'
                : (replyTo.content ?? ''),
            style: TextStyle(
              color: textColor.withValues(alpha: 0.7),
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ReactionsRow extends StatelessWidget {
  final List<MessageReaction> reactions;

  const _ReactionsRow({required this.reactions});

  @override
  Widget build(BuildContext context) {
    // Group by emoji
    final Map<String, int> emojiCount = {};
    for (final r in reactions) {
      emojiCount[r.emoji] = (emojiCount[r.emoji] ?? 0) + 1;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Wrap(
        spacing: 4,
        children: emojiCount.entries.map((e) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withValues(
                  alpha: 0.3,
                ),
              ),
            ),
            child: Text(
              '${e.key} ${e.value}',
              style: const TextStyle(fontSize: 12),
            ),
          );
        }).toList(),
      ),
    );
  }
}
