import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/message.dart';
import '../../../data/remote/socket_event_handler.dart';
import '../../../data/repositories/conversation_repository.dart';
import '../../../data/repositories/message_repository.dart';
import '../chat_view_model.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input_bar.dart';
import '../widgets/reply_preview.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final String conversationName;
  final String? conversationAvatarUrl;

  const ChatScreen({
    super.key,
    required this.conversationId,
    required this.conversationName,
    this.conversationAvatarUrl,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatViewModel _vm;
  final _scrollController = ScrollController();
  Message? _replyingTo;

  @override
  void initState() {
    super.initState();
    _vm = ChatViewModel(
      messageRepository: context.read<MessageRepository>(),
      conversationRepository: context.read<ConversationRepository>(),
      dispatcher: context.read<SocketEventHandler>(),
      conversationId: widget.conversationId,
    );
    _scrollController.addListener(_onScroll);
    _vm.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _vm.removeListener(_onViewModelChanged);
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _vm.dispose();
    super.dispose();
  }

  void _onScroll() {
    // reverse: true → maxScrollExtent = top = oldest messages
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _vm.loadMore();
    }
  }

  void _onViewModelChanged() {
    if (_vm.error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_vm.error!), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatViewModel>.value(
      value: _vm,
      child: _ChatBody(
        conversationName: widget.conversationName,
        conversationAvatarUrl: widget.conversationAvatarUrl,
        scrollController: _scrollController,
        replyingTo: _replyingTo,
        onReplyChanged: (msg) => setState(() => _replyingTo = msg),
      ),
    );
  }
}

class _ChatBody extends StatelessWidget {
  final String conversationName;
  final String? conversationAvatarUrl;
  final ScrollController scrollController;
  final Message? replyingTo;
  final void Function(Message?) onReplyChanged;

  const _ChatBody({
    required this.conversationName,
    required this.conversationAvatarUrl,
    required this.scrollController,
    required this.replyingTo,
    required this.onReplyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatViewModel>();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: conversationAvatarUrl != null
                  ? NetworkImage(conversationAvatarUrl!)
                  : null,
              child: conversationAvatarUrl == null
                  ? Text(
                      conversationName.isNotEmpty
                          ? conversationName[0].toUpperCase()
                          : '?',
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Text(
              conversationName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _MessageList(
                    vm: vm,
                    scrollController: scrollController,
                    onReply: (msg) => onReplyChanged(msg),
                  ),
          ),
          if (replyingTo != null)
            ReplyPreview(
              message: replyingTo!,
              senderName: vm.getSenderName(replyingTo!.senderId),
              onCancel: () => onReplyChanged(null),
            ),
          MessageInputBar(
            isSending: vm.isSending,
            onSend: (text) {
              context.read<ChatViewModel>().sendMessage(
                text,
                replyToId: replyingTo?.id,
              );
              onReplyChanged(null);
            },
          ),
        ],
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  final ChatViewModel vm;
  final ScrollController scrollController;
  final void Function(Message) onReply;

  const _MessageList({
    required this.vm,
    required this.scrollController,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final messages = vm.displayMessages;

    if (messages.isEmpty) {
      return const Center(
        child: Text(
          'Chưa có tin nhắn nào',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: messages.length + (vm.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        // Loading indicator ở đầu list (phía trên = cũ nhất)
        if (index == messages.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        // reverse: true → index 0 = newest (bottom)
        final message = messages[messages.length - 1 - index];
        final isMe = message.senderId == vm.myUserId;

        return MessageBubble(
          message: message,
          isMe: isMe,
          senderName: vm.getSenderName(message.senderId),
          senderAvatarUrl: vm.getSenderAvatarUrl(message.senderId),
          replySenderName: message.replyTo != null
              ? vm.getSenderName(message.replyTo!.senderId)
              : null,
          onLongPress: () => _showMessageActions(context, message, isMe),
          onReply: () => onReply(message),
        );
      },
    );
  }

  void _showMessageActions(
    BuildContext context,
    Message message,
    bool isMe,
  ) {
    if (message.isDeleted) return;
    final vm = context.read<ChatViewModel>();

    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.reply),
              title: const Text('Trả lời'),
              onTap: () {
                Navigator.pop(context);
                onReply(message);
              },
            ),
            if (isMe) ...[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Chỉnh sửa'),
                onTap: () {
                  Navigator.pop(context);
                  _showEditDialog(context, vm, message);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Xóa',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  vm.deleteMessage(message.id);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    ChatViewModel vm,
    Message message,
  ) {
    final controller = TextEditingController(text: message.content);
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Chỉnh sửa tin nhắn'),
        content: TextField(
          controller: controller,
          maxLines: null,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              final newContent = controller.text.trim();
              if (newContent.isNotEmpty) {
                vm.editMessage(message.id, newContent);
              }
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }
}
