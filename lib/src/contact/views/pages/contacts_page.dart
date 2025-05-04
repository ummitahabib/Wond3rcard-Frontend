import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/contact/data/controller/contact_controller.dart';
import 'package:wond3rcard/src/contact/views/pages/mobile/no_contact_connection_screen.dart';

import 'package:shimmer/shimmer.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';

class ContactsPage extends ConsumerWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileNotifier = ref.read(profileProvider);
    final userId = profileNotifier.profileData?.payload.user.id ?? '';
    final contactsAsync = ref.watch(contactsControllerProvider(userId));

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final connectionsNotifier = ref.watch(connectionListProvider.notifier);
        final profileNotifier = ref.read(profileProvider);
        final userId = profileNotifier.profileData?.payload.user.id ?? '';
        await connectionsNotifier.getConnections();
        await profileNotifier.getProfile(context);
        await ref.read(contactsControllerProvider(userId));
      });
      return null;
    }, []);

    return contactsAsync.when(
      loading: () => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
              ),
              title: Container(
                height: 16,
                color: Colors.grey[300],
              ),
              subtitle: Container(
                height: 14,
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
      ),
      error: (e, st) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Network failed, try again later.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.refresh(contactsControllerProvider(userId));
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (contacts) {
        if (contacts.isEmpty) {
          return const NoContactsScreen();
        }

        return Scaffold(
           floatingActionButton: CircleAvatar(
        backgroundColor: AppColors.primaryShade,
        child: IconButton(
          color: AppColors.primaryShade,
          icon: Icon(
            Icons.add,
            color: AppColors.defaultWhite,
          ),
          onPressed: () {
            context.go(RouteString.addContact);
          },
        ),
      ),
          body: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: contacts.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final contact = contacts[index];
              final name = '${contact['firstname']} ${contact['lastname']}';
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(name),
                subtitle: Text(contact['email'] ?? ''),
              );
            },
          ),
        );
      },
    );
  }
}
