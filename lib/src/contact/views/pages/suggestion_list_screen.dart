import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/contact/data/controller/contact_controller.dart';

class SuggestionListScreen extends ConsumerWidget {
  const SuggestionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestions = ref.watch(suggestionListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("People You May Know")),
      body: suggestions.when(
        data: (users) => ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: user.profileUrl.isNotEmpty
                    ? NetworkImage("https://yourdomain.com/${user.profileUrl}")
                    : null,
                child: user.profileUrl.isEmpty
                    ? Text(user.firstname[0].toUpperCase())
                    : null,
              ),
              title: Text('${user.firstname} ${user.lastname}'),
              subtitle: Text(user.email),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text("Connect"),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
