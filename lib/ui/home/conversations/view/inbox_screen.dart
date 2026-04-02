import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/friendship_info.dart';
import '../../../../data/models/search_user_result.dart';
import '../inbox_view_model.dart';
import '../widgets/user_profile_bottom_sheet.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
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
      body: _isSearching
          ? _buildSearchResults(theme)
          : _buildInboxPlaceholder(),
    );
  }

  Widget _buildInboxPlaceholder() {
    return const Center(child: Text('No conversations yet'));
  }

  Widget _buildSearchResults(ThemeData theme) {
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
                Icon(Icons.search, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'Search by name or username',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        if (vm.results.isEmpty) {
          return Center(
            child: Text(
              'No users found',
              style: TextStyle(color: Colors.grey[600]),
            ),
          );
        }

        return ListView.builder(
          itemCount: vm.results.length,
          itemBuilder: (context, index) {
            final item = vm.results[index];
            return _buildUserTile(context, theme, item);
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

    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey[200],
        backgroundImage: user.avatarUrl != null
            ? NetworkImage(user.avatarUrl!)
            : null,
        child: user.avatarUrl == null
            ? Icon(Icons.person, color: Colors.grey[500])
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
    return switch (friendship.status) {
      FriendshipStatus.accepted => Chip(
        label: const Text('Friends'),
        labelStyle: TextStyle(fontSize: 12, color: theme.colorScheme.primary),
        side: BorderSide(color: theme.colorScheme.primary),
        visualDensity: VisualDensity.compact,
      ),
      FriendshipStatus.pendingSent => Chip(
        label: const Text('Sent'),
        labelStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
        side: BorderSide(color: Colors.grey[400]!),
        visualDensity: VisualDensity.compact,
      ),
      FriendshipStatus.pendingReceived => Chip(
        label: const Text('Pending'),
        labelStyle: const TextStyle(fontSize: 12, color: Colors.orange),
        side: const BorderSide(color: Colors.orange),
        visualDensity: VisualDensity.compact,
      ),
      _ => null,
    };
  }
}
