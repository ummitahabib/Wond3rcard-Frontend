import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/admin_analytics.dart';
import 'package:wond3rcard/src/contact/data/controller/contact_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';

class ConnectionSuggestionScreen extends ConsumerWidget {
  const ConnectionSuggestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestionsAsync = ref.watch(suggestionListProvider);
    final connectStates = ref.watch(contactAndconnectUserProvider);
    final isMobile = MediaQuery.of(context).size.width < 600;
    final profileNotifier = ref.read(profileProvider);
    final uId = profileNotifier.profileData?.payload.user.id ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("People you may know"),
        backgroundColor: Colors.deepPurple,
        leading: GestureDetector(
          onTap: () {
            isDesktop(context)
                ? context.go(RouteString.connections)
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
      ),
      body: suggestionsAsync.when(
        loading: () => Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: isMobile ? 3.2 : 1.6,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return _loadingShimmer();
            },
          ),
        ),
        error: (err, _) => Center(child: Text("Error: $err")),
        data: (suggestions) {
          if (suggestions.isEmpty) {
            return const Center(child: Text("No suggestions available."));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: isMobile ? 3.2 : 1.6,
              ),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final user = suggestions[index];
                return Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: reusableContainerDeco(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.account_circle,
                          size: 48, color: Colors.deepPurple),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${user.firstname} ${user.lastname}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(user.email),
                          if (user.companyName.isNotEmpty)
                            Text(user.companyName,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      GestureDetector(
                        onTap: connectStates[user.id] == true
                            ? null
                            : () async {
                                await ref
                                    .read(
                                        contactAndconnectUserProvider.notifier)
                                    .connect(user.uid, user.email, uId);
                                await ref
                                    .read(connectionListProvider.notifier)
                                    .getConnections();
                                await ref
                                    .read(suggestionListProvider.notifier)
                                    .fetchSuggestions();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Connected to ${user.firstname}')),
                                );
                              },
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(9),
                          margin: EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: AppColors.primaryShade,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              connectStates[user.id] == true
                                  ? "Connecting..."
                                  : "Connect",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Container _loadingShimmer() {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: reusableContainerDeco(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Container(
                  width: 100,
                  height: 16,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 5),
                Container(
                  width: 120,
                  height: 16,
                  color: Colors.grey[300],
                ),
              ],
            ),
            const SizedBox(width: 10),
            Container(
              width: 80,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
