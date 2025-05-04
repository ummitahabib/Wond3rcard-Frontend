import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/contact/data/controller/contact_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';

class ConnectionsListScreen extends ConsumerWidget {
  const ConnectionsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connections = ref.watch(connectionListProvider);

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
            context.go(RouteString.suggestion);
          },
        ),
      ),
      body: connections.when(
        data: (list) => ListView.separated(
          itemCount: list.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final user = list[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text(
                    user['firstname']?.substring(0, 1).toUpperCase() ?? '?'),
              ),
              title: Text('${user['firstname']} ${user['lastname']}'),
              subtitle: Text(user['email']),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Optional: Navigate to contact details page
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 50),
              const SizedBox(height: 16),
              const Text(
                'Network failed, try again later',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.refresh(connectionListProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
