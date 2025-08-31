import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/auth/repository/auth_repository.dart';
import 'package:afiyyah_connect/features/auth/view_model/app_user_provider.dart';
import 'package:afiyyah_connect/features/auth/view_model/auth_provider.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/common/widgets/dateinfo_component.dart';
import 'package:afiyyah_connect/features/dashboard/constants/dashboard_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDashboardAppBar extends ConsumerWidget {
  final UserModel user;

  const CustomDashboardAppBar({required this.user, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to user changes to rebuild the UI with the new name
    final updatedUser = ref.watch(appUserProvider).asData?.value ?? user;

    return Row(
      children: [
        _buildProfileBar(context, ref, updatedUser),
        const Spacer(),
        DateInfo(
          textTheme: context.textTheme,
          customTextStyle: context.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileBar(
    BuildContext context,
    WidgetRef ref,
    UserModel updatedUser,
  ) {
    return InkWell(
      onTap: () => _showUserInfoDialog(context, ref, updatedUser),
      child: Row(
        spacing: AppSpacing.m,
        children: [
          CircleAvatar(child: Text(user.fullName.getInitials())),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(updatedUser.fullName, style: context.textTheme.titleSmall),
              Text(
                Role.name(user.role),
                style: context.textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showUserInfoDialog(
    BuildContext context,
    WidgetRef ref,
    UserModel updatedUser,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            DashboardStrings.userInfo,
            style: context.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 30,
                  child: Text(
                    user.fullName.getInitials(),
                    style: context.textTheme.headlineSmall,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.l),
              _buildUserName(dialogContext, context, ref, updatedUser),
              SizedBox(height: AppSpacing.m),
              Text(
                DashboardStrings.email,
                style: context.textTheme.labelMedium!.copyWith(
                  color: Colors.blueGrey,
                ),
              ),
              Text(updatedUser.email, style: context.textTheme.bodyLarge),
              SizedBox(height: AppSpacing.m),
              Text(
                DashboardStrings.role,
                style: context.textTheme.labelMedium!.copyWith(
                  color: Colors.blueGrey,
                ),
              ),
              Text(
                Role.name(updatedUser.role),
                style: context.textTheme.bodyLarge,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(DashboardStrings.close),
            ),
            FilledButton.tonal(
              style: FilledButton.styleFrom(
                backgroundColor: context.colorScheme.errorContainer,
                foregroundColor: context.colorScheme.onErrorContainer,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the info dialog
                _showSignOutConfirmationDialog(context, ref);
              },
              child: const Text(DashboardStrings.signOut),
            ),
          ],
        );
      },
    );
  }

  InkWell _buildUserName(
    BuildContext dialogContext,
    BuildContext context,
    WidgetRef ref,
    UserModel updatedUser,
  ) {
    return InkWell(
      onDoubleTap: () {
        Navigator.of(dialogContext).pop(); // Close info dialog
        _showEditNameDialog(context, ref, updatedUser);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DashboardStrings.name,
            style: context.textTheme.labelMedium!.copyWith(
              color: Colors.blueGrey,
            ),
          ),
          Text(updatedUser.fullName, style: context.textTheme.bodyLarge),
        ],
      ),
    );
  }

  void _showEditNameDialog(
    BuildContext context,
    WidgetRef ref,
    UserModel updatedUser,
  ) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: updatedUser.fullName);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(DashboardStrings.editName),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: DashboardStrings.fullName),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return DashboardStrings.nameCannotBeEmpty;
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(DashboardStrings.cancel),
            ),
            FilledButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final newName = nameController.text.trim();
                  Navigator.of(dialogContext).pop(); // Close edit dialog

                  try {
                    await ref
                        .read(authRepositoryProvider)
                        .updateUserName(newName);
                    ref.invalidate(appUserProvider); // Refresh user data
                    
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(DashboardStrings.nameUpdatedSuccess),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${DashboardStrings.nameUpdatedFailed} $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              },
              child: const Text(DashboardStrings.save),
            ),
          ],
        );
      },
    );
  }

  void _showSignOutConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(DashboardStrings.signOutConfirmation),
          content: const Text(DashboardStrings.signOutConfirmationMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(DashboardStrings.cancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: context.colorScheme.error,
                foregroundColor: context.colorScheme.onError,
              ),
              onPressed: () {
                ref.read(authProviderProvider.notifier).signOut();
                Navigator.of(dialogContext).pop(); // Close confirmation dialog
              },
              child: const Text(DashboardStrings.yesSignOut),
            ),
          ],
        );
      },
    );
  }
}
