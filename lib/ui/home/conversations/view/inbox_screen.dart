import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../data/local/token_storage.dart';
import '../../../../data/models/conversation.dart';
import '../../../../data/models/friendship_info.dart';
import '../../../../data/models/search_user_result.dart';
import '../../../theme/app_colors.dart';
import '../inbox_view_model.dart';
import '../widgets/user_profile_bottom_sheet.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final userId = TokenStorage.instance.userId;
    if (userId != null) {
      context.read<InboxViewModel>().init(userId);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InboxViewModel>().addListener(_onViewModelChanged);
    });
  }

  String? _lastError;

  void _onViewModelChanged() {
    final error = context.read<InboxViewModel>().error;
    if (error != null && error != _lastError) {
      _lastError = error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<InboxViewModel>().loadMore();
    }
  }

  @override
  void dispose() {
    context.read<InboxViewModel>().removeListener(_onViewModelChanged);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search users...',
                  border: InputBorder.none,
                  filled: false,
                ),
                onChanged: (value) {
                  context.read<InboxViewModel>().onQueryChanged(value);
                },
              )
            : const Text('Inbox'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  context.read<InboxViewModel>().onQueryChanged('');
                }
              });
            },
          ),
        ],
      ),
      body: _isSearching ? _buildSearchResults(theme) : _buildInbox(theme),
    );
  }

  Widget _buildInbox(ThemeData theme) {
    return Consumer<InboxViewModel>(
      builder: (context, vm, _) {
        if (!vm.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }
        if (vm.conversations.isEmpty) {
          return const Center(child: Text('No conversations yet'));
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: vm.conversations.length + (vm.isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == vm.conversations.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return _buildConversationTile(theme, vm.conversations[index]);
          },
        );
      },
    );
  }

  Widget _buildConversationTile(ThemeData theme, Conversation item) {
    final colors = theme.colorScheme;
    final lastMsg = item.lastMessage;

    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: colors.surfaceContainerHighest,
        backgroundImage: item.avatarUrl != null
            ? NetworkImage(item.avatarUrl!)
            : null,
        child: item.avatarUrl == null
            ? Icon(Icons.person, color: colors.onSurfaceVariant)
            : null,
      ),
      title: Text(
        item.name ?? 'Unknown',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: lastMsg != null
          ? Text(
              lastMsg.content ?? '(deleted)',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: item.unreadCount > 0
                    ? colors.onSurface
                    : colors.onSurfaceVariant,
                fontWeight: item.unreadCount > 0
                    ? FontWeight.w500
                    : FontWeight.normal,
              ),
            )
          : null,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (lastMsg != null)
            Text(
              _formatTime(item.updatedAt),
              style: TextStyle(
                fontSize: 12,
                color: item.unreadCount > 0 ? colors.primary : colors.outline,
              ),
            ),
          if (item.unreadCount > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                item.unreadCount > 99 ? '99+' : '${item.unreadCount}',
                style: TextStyle(
                  fontSize: 11,
                  color: colors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      onTap: () {
        final name = Uri.encodeComponent(item.name ?? '');
        final avatarUrl = item.avatarUrl != null
            ? Uri.encodeComponent(item.avatarUrl!)
            : null;
        final uri = '/chat/${item.id}?name=$name'
            '${avatarUrl != null ? '&avatarUrl=$avatarUrl' : ''}';
        context.push(uri);
      },
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt.toLocal());
    if (diff.inDays == 0) {
      return '${dt.toLocal().hour.toString().padLeft(2, '0')}:${dt.toLocal().minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[dt.toLocal().weekday - 1];
    } else {
      return '${dt.day}/${dt.month}/${dt.year}';
    }
  }

  // ─── Search ───────────────────────────────────────────────────────────────

  Widget _buildSearchResults(ThemeData theme) {
    final colors = theme.colorScheme;

    return Consumer<InboxViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (vm.error != null) {
          return Center(child: Text(vm.error!));
        }

        if (_searchController.text.trim().isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search, size: 64, color: colors.outline),
                const SizedBox(height: 16),
                Text(
                  'Search by name or username',
                  style: TextStyle(color: colors.onSurfaceVariant),
                ),
              ],
            ),
          );
        }

        if (vm.results.isEmpty) {
          return Center(
            child: Text(
              'No users found',
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          );
        }

        return ListView.builder(
          itemCount: vm.results.length,
          itemBuilder: (context, index) {
            return _buildUserTile(context, theme, vm.results[index]);
          },
        );
      },
    );
  }

  Widget _buildUserTile(
    BuildContext context,
    ThemeData theme,
    SearchUserResult item,
  ) {
    final user = item.user;
    final friendship = item.friendship;
    final colors = theme.colorScheme;

    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: colors.surfaceContainerHighest,
        backgroundImage: user.avatarUrl != null
            ? NetworkImage(user.avatarUrl!)
            : null,
        child: user.avatarUrl == null
            ? Icon(Icons.person, color: colors.onSurfaceVariant)
            : null,
      ),
      title: Text(
        user.fullName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text('@${user.username}'),
      trailing: _buildStatusBadge(theme, friendship),
      onTap: () {
        showUserProfileBottomSheet(context, item);
      },
    );
  }

  Widget? _buildStatusBadge(ThemeData theme, FriendshipInfo friendship) {
    final colors = theme.colorScheme;
    final appColors = theme.extension<AppColors>()!;

    return switch (friendship.status) {
      FriendshipStatus.accepted => Chip(
        label: const Text('Friends'),
        labelStyle: TextStyle(fontSize: 12, color: colors.primary),
        side: BorderSide(color: colors.primary),
        visualDensity: VisualDensity.compact,
      ),
      FriendshipStatus.pendingSent => Chip(
        label: const Text('Sent'),
        labelStyle: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
        side: BorderSide(color: colors.outline),
        visualDensity: VisualDensity.compact,
      ),
      FriendshipStatus.pendingReceived => Chip(
        label: const Text('Pending'),
        labelStyle: TextStyle(fontSize: 12, color: appColors.warning),
        side: BorderSide(color: appColors.warning),
        visualDensity: VisualDensity.compact,
      ),
      _ => null,
    };
  }
}
