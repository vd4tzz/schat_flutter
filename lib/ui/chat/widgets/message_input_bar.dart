import 'package:flutter/material.dart';

class MessageInputBar extends StatefulWidget {
  final void Function(String text) onSend;
  final bool isSending;

  const MessageInputBar({
    super.key,
    required this.onSend,
    this.isSending = false,
  });

  @override
  State<MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<MessageInputBar> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty || widget.isSending) return;
    widget.onSend(text);
    _controller.clear();
    setState(() => _hasText = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.send,
                maxLines: 4,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'Nhắn tin...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor:
                      theme.colorScheme.surfaceContainerHighest,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                onChanged: (v) {
                  final hasText = v.trim().isNotEmpty;
                  if (hasText != _hasText) {
                    setState(() => _hasText = hasText);
                  }
                },
                onSubmitted: (_) => _send(),
              ),
            ),
            const SizedBox(width: 6),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: (_hasText && !widget.isSending)
                  ? IconButton(
                      key: const ValueKey('send'),
                      onPressed: _send,
                      icon: Icon(
                        Icons.send_rounded,
                        color: theme.colorScheme.primary,
                      ),
                    )
                  : widget.isSending
                  ? const SizedBox(
                      key: ValueKey('loading'),
                      width: 40,
                      height: 40,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : const SizedBox(key: ValueKey('empty'), width: 40),
            ),
          ],
        ),
      ),
    );
  }
}
