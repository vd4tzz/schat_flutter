import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/image_utils.dart';
import '../profile_view_model.dart';
import 'user_profile_detail_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfileViewModel>().loadProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ProfileViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.error != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(viewModel.error!),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => viewModel.loadProfile(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final user = viewModel.user;
            if (user == null) {
              return const Center(child: Text('No user data'));
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // Background only
                      _buildBackground(context, viewModel, user),
                      // Avatar (clickable)
                      _buildAvatar(context, viewModel, user),
                      // Full Name & Username
                      Transform.translate(
                        offset: const Offset(0, -50),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              Text(
                                user.fullName,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '@${user.username}',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey[600]),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -30),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Material(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(12),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              leading: const Icon(Icons.person_outline),
                              title: const Text('My Profile'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ChangeNotifierProvider.value(
                                          value: context
                                              .read<ProfileViewModel>(),
                                          child:
                                              const UserProfileDetailScreen(),
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Loading overlay
                if (viewModel.isUploading)
                  Container(
                    color: Colors.black.withAlpha(100),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBackground(
    BuildContext context,
    ProfileViewModel viewModel,
    dynamic user,
  ) {
    return GestureDetector(
      onTap: () => _showImagePickerSheet(context, viewModel, isAvatar: false),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withAlpha(30),
              Theme.of(context).colorScheme.primary.withAlpha(10),
            ],
          ),
        ),
        child: user.backgroundUrl != null
            ? Image.network(
                user.backgroundUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(),
              )
            : null,
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context,
    ProfileViewModel viewModel,
    dynamic user,
  ) {
    const avatarSize = 120.0;

    return Transform.translate(
      offset: const Offset(0, -60),
      child: Center(
        child: GestureDetector(
          onTap: () =>
              _showImagePickerSheet(context, viewModel, isAvatar: true),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.surface,
                width: 5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(100),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: avatarSize / 2,
              backgroundColor: Colors.grey[200],
              backgroundImage: user.avatarUrl != null
                  ? NetworkImage(user.avatarUrl!)
                  : null,
              child: user.avatarUrl == null
                  ? Icon(
                      Icons.person,
                      size: avatarSize / 2.5,
                      color: Colors.grey[500],
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePickerSheet(
    BuildContext context,
    ProfileViewModel viewModel, {
    required bool isAvatar,
  }) {
    final user = viewModel.user;
    final hasExisting = isAvatar
        ? user?.avatarUrl != null
        : user?.backgroundUrl != null;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickAndCropImage(context, viewModel, isAvatar: isAvatar);
              },
            ),
            if (hasExisting) ...[
              ListTile(
                leading: const Icon(Icons.preview),
                title: const Text('View Image'),
                onTap: () {
                  Navigator.pop(context);
                  _showImageViewer(
                    context,
                    isAvatar ? user?.avatarUrl : user?.backgroundUrl,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  if (isAvatar) {
                    await viewModel.deleteAvatar();
                  } else {
                    await viewModel.deleteBackground();
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _pickAndCropImage(
    BuildContext context,
    ProfileViewModel viewModel, {
    required bool isAvatar,
  }) async {
    final pickedPath = await ImageUtils.pickImage();
    if (pickedPath == null) return;

    if (!mounted) return;

    final croppedPath = await ImageUtils.cropImage(
      pickedPath,
      aspectRatio: isAvatar
          ? const CropAspectRatio(ratioX: 1, ratioY: 1)
          : const CropAspectRatio(ratioX: 16, ratioY: 9),
      cropStyle: isAvatar ? CropStyle.circle : CropStyle.rectangle,
      maxWidth: isAvatar ? 512 : 1920,
      maxHeight: isAvatar ? 512 : 1080,
    );

    if (croppedPath == null) return;

    if (mounted) {
      if (isAvatar) {
        await viewModel.uploadAvatar(croppedPath);
      } else {
        await viewModel.uploadBackground(croppedPath);
      }
    }
  }

  void _showImageViewer(BuildContext context, String? imageUrl) {
    if (imageUrl == null) return;

    showDialog(
      context: context,
      builder: (context) => Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Container(
            color: Colors.black,
            child: Center(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      const Text(
                        'Failed to load image',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
