import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/app_notification.dart';
import '../../../../data/models/friend_request.dart';
import '../notifications_view_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsViewModel>().loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NotificationsViewModel>();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (vm.unreadCount > 0)
            TextButton(
              onPressed: vm.markAllAsRead,
              child: Text(
                'Mark all read',
                style: TextStyle(color: colors.primary, fontSize: 13),
              ),
            ),
        ],
      ),
      body: _buildBody(vm, theme),
    );
  }

  Widget _buildBody(NotificationsViewModel vm, ThemeData theme) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 12),
            Text(vm.error!, style: TextStyle(color: theme.colorScheme.error)),
            const SizedBox(height: 16),
            TextButton(
              onPressed: vm.loadNotifications,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (vm.notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.notifications_none,
                size: 64, color: theme.colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              'No notifications yet',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: vm.loadNotifications,
      child: ListView.builder(
        itemCount: vm.notifications.length,
        itemBuilder: (context, index) {
          final notification = vm.notifications[index];
          return _NotificationTile(
            notification: notification,
            onTap: () => _onTap(notification),
            onDismissed: () =>
                context.read<NotificationsViewModel>().deleteNotification(
                      notification.id,
                    ),
          );
        },
      ),
    );
  }

  void _onTap(AppNotification notification) {
    context.read<NotificationsViewModel>().markAsRead(notification.id);

    if (notification.type == AppNotificationType.friendRequest) {
      _showFriendRequestsSheet();
    }
  }

  void _showFriendRequestsSheet() {
    context.read<NotificationsViewModel>().loadIncomingRequests();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<NotificationsViewModel>(),
        child: const _FriendRequestsSheet(),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isUnread = !notification.isRead;

    return Dismissible(
      key: ValueKey(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: colors.error,
        child: Icon(Icons.delete_outline, color: colors.onError),
      ),
      onDismissed: (_) => onDismissed(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: isUnread
              ? colors.primary.withAlpha(12)
              : colors.surface,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(colors),
              const SizedBox(width: 12),
              Expanded(child: _buildContent(theme, colors)),
              if (isUnread)
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(ColorScheme colors) {
    final avatarUrl = notification.actorAvatar;
    return Stack(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: colors.surfaceContainerHighest,
          backgroundImage:
              avatarUrl != null ? NetworkImage(avatarUrl) : null,
          child: avatarUrl == null
              ? Icon(Icons.person, color: colors.onSurfaceVariant)
              : null,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              shape: BoxShape.circle,
              border: Border.all(color: colors.surface, width: 1.5),
            ),
            child: Icon(
              _iconForType(),
              size: 11,
              color: colors.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(ThemeData theme, ColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: theme.textTheme.bodyMedium,
            children: [
              TextSpan(
                text: notification.actorName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const TextSpan(text: ' '),
              TextSpan(text: _bodyText()),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _timeAgo(notification.createdAt),
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  IconData _iconForType() {
    return switch (notification.type) {
      AppNotificationType.friendRequest => Icons.person_add,
      AppNotificationType.friendAccepted => Icons.people,
    };
  }

  String _bodyText() {
    return switch (notification.type) {
      AppNotificationType.friendRequest => 'sent you a friend request.',
      AppNotificationType.friendAccepted => 'accepted your friend request.',
    };
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

class _FriendRequestsSheet extends StatelessWidget {
  const _FriendRequestsSheet();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NotificationsViewModel>();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Handle
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Row(
                children: [
                  Text('Friend Requests',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  if (vm.incomingRequests.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${vm.incomingRequests.length}',
                        style: TextStyle(
                          color: colors.onPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Expanded(
              child: vm.isRequestsLoading
                  ? const Center(child: CircularProgressIndicator())
                  : vm.incomingRequests.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.people_outline,
                                  size: 48, color: colors.outline),
                              const SizedBox(height: 12),
                              Text(
                                'No pending requests',
                                style: TextStyle(
                                    color: colors.onSurfaceVariant),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: vm.incomingRequests.length,
                          itemBuilder: (context, index) =>
                              _FriendRequestItem(
                            request: vm.incomingRequests[index],
                          ),
                        ),
            ),
          ],
        );
      },
    );
  }
}

class _FriendRequestItem extends StatefulWidget {
  final FriendRequest request;

  const _FriendRequestItem({required this.request});

  @override
  State<_FriendRequestItem> createState() => _FriendRequestItemState();
}

class _FriendRequestItemState extends State<_FriendRequestItem> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final req = widget.request;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: colors.surfaceContainerHighest,
            backgroundImage: req.requesterAvatarUrl != null
                ? NetworkImage(req.requesterAvatarUrl!)
                : null,
            child: req.requesterAvatarUrl == null
                ? Icon(Icons.person, color: colors.onSurfaceVariant)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  req.requesterName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '@${req.requesterUsername}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else ...[
            FilledButton(
              onPressed: () => _accept(context),
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Accept', style: TextStyle(fontSize: 13)),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () => _reject(context),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Decline', style: TextStyle(fontSize: 13)),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _accept(BuildContext context) async {
    setState(() => _isLoading = true);
    await context
        .read<NotificationsViewModel>()
        .acceptRequest(widget.request.id);
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _reject(BuildContext context) async {
    setState(() => _isLoading = true);
    await context
        .read<NotificationsViewModel>()
        .rejectRequest(widget.request.id);
    if (mounted) setState(() => _isLoading = false);
  }
}
