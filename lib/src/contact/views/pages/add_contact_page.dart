import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/contact/data/controller/contact_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';

class AddContactPage extends HookConsumerWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final isLoading = ref.watch(addContactControllerProvider).isLoading;

    final profileNotifier = ref.read(profileProvider);
    final userId = profileNotifier.profileData?.payload.user.id ?? '';

    Future<void> _submit() async {
      if (!formKey.currentState!.validate()) return;

      final email = emailController.text.trim();
      await ref.read(addContactControllerProvider.notifier).addContact(
            userId: userId,
            email: email,
          );

      final result = ref.read(addContactControllerProvider);
      result.whenOrNull(
        data: (_) {
          _showSnack(context, 'Contact added successfully');
          emailController.clear();
        },
        error: (error, _) {
          final errorMsg = error.toString();
          if (errorMsg.contains("not found")) {
            _showInviteDialog(context, email);
          } else {
            _showSnack(context, 'Error: $errorMsg');
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              isDesktop(context)
                  ? context.go(RouteString.baseDashboard)
                  : context.go(RouteString.mainDashboard);
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.defaultWhite,
              ),
              child: HeroIcon(HeroIcons.arrowLeft, color: AppColors.grayScale),
            ),
          ),
          title: const Text('Add Contact')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;

          return Center(
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.all(16),
              child: Container(
                width: isWide ? 500 : double.infinity,
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Enter the email of someone you’d like to add as a contact',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Contact Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          if (email.isEmpty) return 'Email cannot be empty';
                          if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$')
                              .hasMatch(email)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: isLoading ? null : _submit,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(9),
                          margin: EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: AppColors.primaryShade,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.person_add,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    )
                                  : const Text(
                                      'Add Contact',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showInviteDialog(BuildContext context, String email) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("User Not Found"),
          content: Text(
            "We couldn't find a user with the email \"$email\".\nWould you like to invite them to join the platform?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                _showInviteConfirmation(context, email);
              },
              icon: const Icon(Icons.send),
              label: const Text("Send Invite"),
            ),
          ],
        );
      },
    );
  }

  void _showInviteConfirmation(BuildContext context, String email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Invitation Sent"),
        content: Text("An invitation has been sent to $email."),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}
