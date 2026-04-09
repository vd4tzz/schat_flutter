import 'package:flutter/material.dart';

const _quickEmojis = ['❤️', '😆', '😮', '😢', '👍', '👎'];
const _emojiRowWidth = 272.0;
const _emojiRowHeight = 52.0;

void showReactionOverlay({
  required BuildContext context,
  required Rect bubbleRect,
  required bool isMe,
  required bool isDeleted,
  required String? myCurrentReaction,
  required void Function(String?) onReact,
  required VoidCallback onReply,
  VoidCallback? onEdit,
  VoidCallback? onDelete,
}) {
  final overlay = Overlay.of(context);
  OverlayEntry? entry;

  void dismiss() {
    entry?.remove();
    entry = null;
  }

  entry = OverlayEntry(
    builder: (_) => _ReactionOverlay(
      bubbleRect: bubbleRect,
      isMe: isMe,
      isDeleted: isDeleted,
      myCurrentReaction: myCurrentReaction,
      onReact: (emoji) {
        dismiss();
        onReact(emoji);
      },
      onReply: () {
        dismiss();
        onReply();
      },
      onEdit: onEdit == null
          ? null
          : () {
              dismiss();
              onEdit();
            },
      onDelete: onDelete == null
          ? null
          : () {
              dismiss();
              onDelete();
            },
      onDismiss: dismiss,
    ),
  );

  overlay.insert(entry!);
}

class _ReactionOverlay extends StatefulWidget {
  final Rect bubbleRect;
  final bool isMe;
  final bool isDeleted;
  final String? myCurrentReaction;
  final void Function(String?) onReact;
  final VoidCallback onReply;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback onDismiss;

  const _ReactionOverlay({
    required this.bubbleRect,
    required this.isMe,
    required this.isDeleted,
    required this.myCurrentReaction,
    required this.onReact,
    required this.onReply,
    this.onEdit,
    this.onDelete,
    required this.onDismiss,
  });

  @override
  State<_ReactionOverlay> createState() => _ReactionOverlayState();
}

class _ReactionOverlayState extends State<_ReactionOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleCurve;
  late final Animation<double> _fadeCurve;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleCurve =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack);
    _fadeCurve = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenSize = mq.size;
    final safeTop = mq.padding.top;

    // ── Emoji row position ─────────────────────────────────────────────────
    double emojiTop = widget.bubbleRect.top - _emojiRowHeight - 8;
    final emojiBelow = emojiTop < safeTop + 8;
    if (emojiBelow) emojiTop = widget.bubbleRect.bottom + 8;

    double emojiLeft = widget.isMe
        ? widget.bubbleRect.right - _emojiRowWidth
        : widget.bubbleRect.left;
    emojiLeft = emojiLeft.clamp(8.0, screenSize.width - _emojiRowWidth - 8);

    // ── Action menu position ───────────────────────────────────────────────
    // If emoji is below bubble, action menu goes above bubble.
    // Otherwise action menu goes below bubble.
    final double actionTop;
    if (emojiBelow) {
      actionTop = widget.bubbleRect.top - _estimateMenuHeight() - 8;
    } else {
      actionTop = widget.bubbleRect.bottom + 8;
    }

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Dimmed background — tap to dismiss
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.onDismiss,
              child: FadeTransition(
                opacity: _fadeCurve,
                child: Container(color: Colors.black54),
              ),
            ),
          ),

          // Emoji row
          Positioned(
            top: emojiTop,
            left: emojiLeft,
            child: ScaleTransition(
              scale: _scaleCurve,
              alignment: widget.isMe
                  ? Alignment.bottomRight
                  : Alignment.bottomLeft,
              child: FadeTransition(
                opacity: _fadeCurve,
                child: _EmojiRow(
                  myCurrentReaction: widget.myCurrentReaction,
                  onReact: widget.onReact,
                ),
              ),
            ),
          ),

          // Action menu
          if (widget.isMe)
            Positioned(
              top: actionTop,
              right: screenSize.width - widget.bubbleRect.right,
              child: _animatedMenu(Alignment.topRight),
            )
          else
            Positioned(
              top: actionTop,
              left: widget.bubbleRect.left,
              child: _animatedMenu(Alignment.topLeft),
            ),
        ],
      ),
    );
  }

  Widget _animatedMenu(Alignment alignment) {
    return ScaleTransition(
      scale: _scaleCurve,
      alignment: alignment,
      child: FadeTransition(
        opacity: _fadeCurve,
        child: _ActionMenu(
          isDeleted: widget.isDeleted,
          onReply: widget.onReply,
          onEdit: widget.onEdit,
          onDelete: widget.onDelete,
        ),
      ),
    );
  }

  double _estimateMenuHeight() {
    int count = 1; // reply
    if (!widget.isDeleted) {
      if (widget.onEdit != null) count++;
      if (widget.onDelete != null) count++;
    }
    return count * 44.0 + 16;
  }
}

// ─── Emoji row ──────────────────────────────────────────────────────────────

class _EmojiRow extends StatelessWidget {
  final String? myCurrentReaction;
  final void Function(String?) onReact;

  const _EmojiRow({required this.myCurrentReaction, required this.onReact});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _emojiRowWidth,
      height: _emojiRowHeight,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _quickEmojis.map((emoji) {
          final selected = myCurrentReaction == emoji;
          return GestureDetector(
            onTap: () => onReact(selected ? null : emoji),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Text(
                emoji,
                style: TextStyle(fontSize: selected ? 26 : 22),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─── Action menu ─────────────────────────────────────────────────────────────

class _ActionMenu extends StatelessWidget {
  final bool isDeleted;
  final VoidCallback onReply;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const _ActionMenu({
    required this.isDeleted,
    required this.onReply,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minWidth: 160),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MenuItem(icon: Icons.reply, label: 'Trả lời', onTap: onReply),
          if (!isDeleted && onEdit != null) ...[
            const Divider(height: 1, indent: 16, endIndent: 16),
            _MenuItem(
              icon: Icons.edit_outlined,
              label: 'Chỉnh sửa',
              onTap: onEdit!,
            ),
          ],
          if (!isDeleted && onDelete != null) ...[
            const Divider(height: 1, indent: 16, endIndent: 16),
            _MenuItem(
              icon: Icons.delete_outline,
              label: 'Xóa',
              onTap: onDelete!,
              color: Colors.red,
            ),
          ],
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? Theme.of(context).colorScheme.onSurface;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: effectiveColor),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: effectiveColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
