import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/contact/data/controller/contact_controller.dart';
import 'package:wond3rcard/src/contact/views/pages/mobile/no_contact_connection_screen.dart';

import 'package:shimmer/shimmer.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/decoration_box.dart';
import 'package:wond3rcard/src/utils/util.dart';

class ContactsPage extends ConsumerStatefulWidget {
  const ContactsPage({super.key});

  @override
  ConsumerState<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends ConsumerState<ContactsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);
    final userId = profile.profileData?.payload.user.id ?? '';
    final connectStates = ref.watch(connectUserProvider);

    if (userId.isEmpty) {
      return const Center(child: Text('User not found'));
    }

    final contactsAsync = ref.watch(contactsControllerProvider(userId));

    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: AppColors.primaryShade,
        child: IconButton(
          icon: Icon(Icons.add, color: AppColors.defaultWhite),
          onPressed: () => context.go(RouteString.addContact),
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
            child: contactsAsync.when(
              loading: () => _buildShimmerList(),
              error: (e, st) => _buildErrorScreen(context, ref, userId),
              data: (contacts) {
                final filtered = contacts.where((contact) {
                  final fullName =
                      '${contact.firstname} ${contact.lastname}'.toLowerCase();
                  final email = contact.email.toLowerCase();
                  return fullName.contains(_searchQuery.toLowerCase()) ||
                      email.contains(_searchQuery.toLowerCase());
                }).toList();

                if (filtered.isEmpty) return const NoContactsScreen();

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final contact = filtered[index];
                    final isConnecting = connectStates[contact.uid] == true;
                    final connectionListAsync =
                        ref.watch(connectionListProvider);

                    final isConnected = connectionListAsync.when(
                      data: (connections) =>
                          connections.any((c) => c['uid'] == contact.uid),
                      loading: () => false,
                      error: (_, __) => false,
                    );

                    return Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: DecorationBox.detailContainerDecorationBox(),
                      child: Row(
                        children: [
                          const CircleAvatar(child: Icon(Icons.person)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${contact.firstname} ${contact.lastname}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          _ConnectButton(
                            isConnecting: isConnecting,
                            isConnected: isConnected,
                            onPressed: isConnecting
                                ? null
                                : () async {
                                    if (isConnected) {
                                      await ref
                                          .read(connectUserProvider.notifier)
                                          .disconnect(contact.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Disconnected from ${contact.firstname}')),
                                      );
                                    } else {
                                      await ref
                                          .read(connectUserProvider.notifier)
                                          .connect(contact.uid);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Connected to ${contact.firstname}')),
                                      );
                                    }
                                    await ref
                                        .read(connectionListProvider.notifier)
                                        .getConnections();
                                    await ref
                                        .read(suggestionListProvider.notifier)
                                        .fetchSuggestions();
                                  },
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: const ListTile(
            leading: CircleAvatar(backgroundColor: Colors.grey),
            title: SizedBox(
              height: 16,
              child:
                  DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
            ),
            subtitle: SizedBox(
              height: 14,
              child:
                  DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorScreen(BuildContext context, WidgetRef ref, String userId) {
    return Center(
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
            onPressed: () => ref.refresh(contactsControllerProvider(userId)),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _ConnectButton extends StatelessWidget {
  final bool isConnecting;
  final bool isConnected;
  final VoidCallback? onPressed;

  const _ConnectButton({
    required this.isConnecting,
    required this.isConnected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final label = isConnecting
        ? (isConnected ? "Disconnecting..." : "Connecting...")
        : (isConnected ? "Disconnect" : "Connect");

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.primaryShade,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(label, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class Contact {
  final String id;
  final String uid;
  final String firstname;
  final String othername;
  final String lastname;
  final String email;
  final String mobileNumber;
  final String companyName;
  final String designation;
  final String profileUrl;
  final String coverUrl;
  final String plan;

  Contact({
    required this.id,
    required this.uid,
    required this.firstname,
    required this.othername,
    required this.lastname,
    required this.email,
    required this.mobileNumber,
    required this.companyName,
    required this.designation,
    required this.profileUrl,
    required this.coverUrl,
    required this.plan,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['_id'] ?? '',
      uid: json['uid'] ?? '',
      firstname: json['firstname'] ?? '',
      othername: json['othername'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      companyName: json['companyName'] ?? '',
      designation: json['designation'] ?? '',
      profileUrl: json['profileUrl'] ?? '',
      coverUrl: json['coverUrl'] ?? '',
      plan: json['plan'] ?? '',
    );
  }
}
