import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile_view_model.dart';

class UserProfileDetailScreen extends StatefulWidget {
  const UserProfileDetailScreen({super.key});

  @override
  State<UserProfileDetailScreen> createState() =>
      _UserProfileDetailScreenState();
}

class _UserProfileDetailScreenState extends State<UserProfileDetailScreen> {
  bool _isEditing = false;

  late final TextEditingController _fullNameCtrl;
  late final TextEditingController _bioCtrl;
  late final TextEditingController _phoneCtrl;
  String? _gender;
  DateTime? _dateOfBirth;

  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileViewModel>().user;
    _fullNameCtrl = TextEditingController(text: user?.fullName ?? '');
    _bioCtrl = TextEditingController(text: user?.bio ?? '');
    _phoneCtrl = TextEditingController(text: user?.phoneNumber ?? '');
    _gender = user?.gender;
    _dateOfBirth = user?.dateOfBirth;
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _bioCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _enterEdit() {
    final user = context.read<ProfileViewModel>().user;
    if (user == null) return;
    _fullNameCtrl.text = user.fullName;
    _bioCtrl.text = user.bio ?? '';
    _phoneCtrl.text = user.phoneNumber ?? '';
    _gender = user.gender;
    _dateOfBirth = user.dateOfBirth;
    setState(() => _isEditing = true);
  }

  Future<void> _save() async {
    final viewModel = context.read<ProfileViewModel>();
    await viewModel.updateProfile(
      fullName: _fullNameCtrl.text.trim().isNotEmpty
          ? _fullNameCtrl.text.trim()
          : null,
      bio: _bioCtrl.text.trim().isNotEmpty ? _bioCtrl.text.trim() : null,
      phoneNumber: _phoneCtrl.text.trim().isNotEmpty
          ? _phoneCtrl.text.trim()
          : null,
      gender: _gender,
      dateOfBirth: _dateOfBirth,
    );
    if (!mounted) return;
    if (viewModel.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.error!),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      viewModel.clearError();
      return;
    }
    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          Consumer<ProfileViewModel>(
            builder: (context, vm, child) => _isEditing
                ? Row(
                    children: [
                      TextButton(
                        onPressed: vm.isUploading
                            ? null
                            : () => setState(() => _isEditing = false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: vm.isUploading ? null : _save,
                        child: const Text('Save'),
                      ),
                    ],
                  )
                : IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: _enterEdit,
                  ),
          ),
        ],
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, viewModel, _) {
          final user = viewModel.user;
          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildHeader(context, user),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 19),
                    child: Divider(height: 0.5, thickness: 0.5),
                  ),

                  _buildField(
                    context,
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: user.email,
                    readOnly: true,
                  ),
                  _buildField(
                    context,
                    icon: Icons.badge_outlined,
                    label: 'Full Name',
                    value: user.fullName,
                    controller: _fullNameCtrl,
                  ),

                  _buildField(
                    context,
                    icon: Icons.info_outline,
                    label: 'Bio',
                    value: user.bio,
                    controller: _bioCtrl,
                    maxLines: 3,
                  ),
                  _buildGenderField(context, user.gender),
                  _buildDateField(context, user.dateOfBirth),
                  _buildField(
                    context,
                    icon: Icons.phone_outlined,
                    label: 'Phone Number',
                    value: user.phoneNumber,
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
              if (viewModel.isUploading)
                Container(
                  color: Theme.of(context).colorScheme.scrim.withAlpha(80),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic user) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            backgroundImage: user.avatarUrl != null
                ? NetworkImage(user.avatarUrl!)
                : null,
            child: user.avatarUrl == null
                ? Icon(Icons.person, size: 32, color: Theme.of(context).colorScheme.onSurfaceVariant)
                : null,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullName,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                '@${user.username}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    BuildContext context, {
    required IconData icon,
    required String label,
    String? value,
    TextEditingController? controller,
    bool readOnly = false,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: maxLines > 1
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: maxLines > 1 ? 12 : 0),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _isEditing && !readOnly && controller != null
                ? TextField(
                    controller: controller,
                    maxLines: maxLines,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      labelText: label,
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        value?.isNotEmpty == true ? value! : '--',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderField(BuildContext context, String? currentGender) {
    final label = 'Gender';
    final displayValue = _genderLabel(_isEditing ? _gender : currentGender);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(
            Icons.wc_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 22,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _isEditing
                ? DropdownButtonFormField<String>(
                    initialValue: _gender,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'MALE', child: Text('Male')),
                      DropdownMenuItem(value: 'FEMALE', child: Text('Female')),
                      DropdownMenuItem(value: 'OTHER', child: Text('Other')),
                    ],
                    onChanged: (v) => setState(() => _gender = v),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        displayValue ?? '--',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(BuildContext context, DateTime? currentDate) {
    final date = _isEditing ? _dateOfBirth : currentDate;
    final displayValue = date != null ? _formatDate(date) : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(
            Icons.cake_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 22,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _isEditing
                ? InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _dateOfBirth ?? DateTime(2000),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(
                          () => _dateOfBirth = DateTime.utc(
                            picked.year,
                            picked.month,
                            picked.day,
                          ),
                        );
                      }
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder(),
                        isDense: true,
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                        ),
                      ),
                      child: Text(
                        displayValue ?? 'Select date',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: displayValue == null ? Theme.of(context).colorScheme.onSurfaceVariant : null,
                        ),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date of Birth',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        displayValue ?? '--',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  String? _genderLabel(String? gender) {
    switch (gender) {
      case 'MALE':
        return 'Male';
      case 'FEMALE':
        return 'Female';
      case 'OTHER':
        return 'Other';
      default:
        return gender;
    }
  }
}
