import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';

class DeleteAccountMobile extends ConsumerWidget {
  const DeleteAccountMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteState = ref.watch(deleteAccountProvider);
    final deleteController = ref.read(deleteAccountProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sentiment_dissatisfied, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 24),
            Text(
              "We're sad to see you go 😢",
              style: WonderCardTypography.boldTextH3(color: AppColors.grayScale800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Deleting your account is permanent and cannot be undone. Are you sure you want to continue?",
              style: WonderCardTypography.regularTextTitle1(color: AppColors.grayScale600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            if (deleteState.isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text("Confirm Delete"),
                        content: const Text("Are you sure you want to delete this account?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(ctx).pop(); // close dialog
                              await deleteController.deleteAccount("userId", "newTierId");
                              if (context.mounted) {
                                Navigator.of(context).pop(); // maybe return to login or splash
                              }
                            },
                            child: const Text("Yes, Delete", style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text("Delete Account"),
              ),
            if (deleteState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Something went wrong. Please try again.",
                  style: TextStyle(color: Colors.red[600]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
