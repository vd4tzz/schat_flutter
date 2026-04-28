import '../models/message.dart';

typedef MessageSentEvent = ({Message message, String tempId});
typedef MessageDeletedEvent = ({String conversationId, String messageId});
typedef ReactionUpdatedEvent = ({
  String conversationId,
  String messageId,
  String userId,
  String? emoji,
});
typedef ReadReceiptEvent = ({String conversationId, String userId, int seq});
