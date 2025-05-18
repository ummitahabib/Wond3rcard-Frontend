import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/contact/data/controller/contact_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';

// class ConnectionsListScreen extends ConsumerWidget {
//   const ConnectionsListScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final connections = ref.watch(connectionListProvider);

//     return Scaffold(
//       floatingActionButton: CircleAvatar(
//         backgroundColor: AppColors.primaryShade,
//         child: IconButton(
//           color: AppColors.primaryShade,
//           icon: Icon(
//             Icons.add,
//             color: AppColors.defaultWhite,
//           ),
//           onPressed: () {
//             context.go(RouteString.suggestion);
//           },
//         ),
//       ),
//       body: connections.when(
//         data: (list) => ListView.separated(
//           itemCount: list.length,
//           separatorBuilder: (_, __) => const Divider(),
//           itemBuilder: (context, index) {
//             final user = list[index];
//             print('available connections ${user.length}');
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.deepPurple,
//                 child: Text(
//                     user['firstname']?.substring(0, 1).toUpperCase() ?? '?'),
//               ),
//               title: Text('${user['firstname']} ${user['lastname']}'),
//               subtitle: Text(user['email']),
//               trailing: ElevatedButton(
//                 onPressed: () async {
//                   await ref
//                       .read(connectionListProvider.notifier)
//                       .removeConnection(user['uid']); // Use correct field name
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content:
//                             Text('Disconnected from ${user['firstname']}')),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                   foregroundColor: Colors.white,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 ),
//                 child: const Text('Disconnect'),
//               ),
//             );
//           },
//         ),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, _) => Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.error, color: Colors.red, size: 50),
//               const SizedBox(height: 16),
//               const Text(
//                 'Network failed, try again later',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   ref.refresh(connectionListProvider);
//                 },
//                 child: const Text('Retry'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ConnectionsListScreen extends ConsumerStatefulWidget {
  const ConnectionsListScreen({super.key});

  @override
  ConsumerState<ConnectionsListScreen> createState() =>
      _ConnectionsListScreenState();
}

class _ConnectionsListScreenState extends ConsumerState<ConnectionsListScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectionsAsync = ref.watch(connectionListProvider);

    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: AppColors.primaryShade,
        child: IconButton(
          icon: Icon(Icons.add, color: AppColors.defaultWhite),
          onPressed: () => context.go(RouteString.suggestion),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or email',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          Expanded(
            child: connectionsAsync.when(
              data: (list) {
                final filtered = list.where((user) {
                  final name =
                      '${user['firstname']} ${user['lastname']}'.toLowerCase();
                  final email = user['email']?.toLowerCase() ?? '';
                  return name.contains(_searchQuery.toLowerCase()) ||
                      email.contains(_searchQuery.toLowerCase());
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('No matching connections.'));
                }

                return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final user = filtered[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Text(
                            user['firstname']?.substring(0, 1).toUpperCase() ??
                                '?'),
                      ),
                      title: Text('${user['firstname']} ${user['lastname']}'),
                      subtitle: Text(user['email']),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          await ref
                              .read(connectionListProvider.notifier)
                              .removeConnection(user['uid']);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Disconnected from ${user['firstname']}')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                        child: const Text('Disconnect'),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 50),
                    const SizedBox(height: 16),
                    const Text(
                      'Network failed, try again later',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.refresh(connectionListProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
