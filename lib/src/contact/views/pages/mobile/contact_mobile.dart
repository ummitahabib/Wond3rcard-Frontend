import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/contact/data/controller/contact_controller.dart';




class ContactsPage extends ConsumerWidget {
  final String userId;

  const ContactsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(contactsControllerProvider(userId));

    return contactsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (contacts) {
          if (contacts.isEmpty) {
            return const Center(child: Text('No contacts added yet.'));
          }

          return ListView.separated(
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
          );
        },
      )
    ;
  }
}
