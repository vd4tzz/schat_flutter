import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/friendship_info.dart';
import '../../../../data/models/search_user_result.dart';
import '../inbox_view_model.dart';

void showUserProfileBottomSheet(BuildContext context, SearchUserResult item) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => ChangeNotifierProvider.value(
      value: context.read<InboxViewModel>(),
      child: _UserProfileSheet(item: item),
    ),
  );
}

class _UserProfileSheet extends StatelessWidget {
  final SearchUserResult item;

  const _UserProfileSheet({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = item.user;

    // Get latest friendship from ViewModel
    final vm = context.watch<InboxViewModel>();
    final currentItem =
        vm.results.where((r) => r.user.id == user.id).firstOrNull;
    final friendship = currentItem?.friendship ?? item.friendship;

    final isBlockedByThem =
        friendship.status == FriendshipStatus.blockedByThem;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),

          // Avatar
          CircleAvatar(
            radius: 52,
            backgroundColor: Colors.grey[200],
            backgroundImage:
                user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
            child: user.avatarUrl == null
                ? Icon(Icons.person, size: 52, color: Colors.grey[500])
                : null,
          ),
          const SizedBox(height: 20),

          // Name
          Text(
            user.fullName,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),

          // Username
          Text(
            '@${user.username}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),

          // Bio
          if (user.bio != null && user.bio!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              user.bio!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          const SizedBox(height: 32),

          // Action buttons (hidden if blocked)
          if (!isBlockedByThem) ...[
            Row(
              children: [
                // Message button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Navigate to chat
                    },
                    icon: const Icon(Icons.chat_bubble_outline, size: 18),
                    label: const Text('Message'),
                  ),
                ),
                const SizedBox(width: 12),
                // Friendship button
                Expanded(
                  child: _buildFriendshipButton(context, theme, friendship),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],

          // Safe area padding
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom),
        ],
      ),
    );
  }

  void _showFriendOptions(BuildContext context, FriendshipInfo friendship) {
    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(item.user.fullName),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await context.read<InboxViewModel>().unfriend(
                    item.user.id,
                    friendship.friendshipId!,
                  );
            },
            child: const Row(
              children: [
                Icon(Icons.person_remove, color: Colors.red, size: 20),
                SizedBox(width: 12),
                Text('Unfriend', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendshipButton(
    BuildContext context,
    ThemeData theme,
    FriendshipInfo friendship,
  ) {
    return switch (friendship.status) {
      FriendshipStatus.accepted => OutlinedButton.icon(
          onPressed: () => _showFriendOptions(context, friendship),
          icon: const Icon(Icons.check, size: 18),
          label: const Text('Friends'),
        ),
      FriendshipStatus.pendingSent => OutlinedButton.icon(
          onPressed: null,
          icon: const Icon(Icons.schedule, size: 18),
          label: const Text('Sent'),
        ),
      FriendshipStatus.pendingReceived => ElevatedButton.icon(
          onPressed: () {
            // TODO: Accept friend request
          },
          icon: const Icon(Icons.person_add, size: 18),
          label: const Text('Accept'),
        ),
      FriendshipStatus.blockedByYou => OutlinedButton.icon(
          onPressed: null,
          icon: const Icon(Icons.block, size: 18),
          label: const Text('Blocked'),
        ),
      _ => OutlinedButton.icon(
          onPressed: () async {
            await context
                .read<InboxViewModel>()
                .sendFriendRequest(item.user.id);
          },
          icon: const Icon(Icons.person_add_outlined, size: 18),
          label: const Text('Add Friend'),
        ),
    };
  }
}
