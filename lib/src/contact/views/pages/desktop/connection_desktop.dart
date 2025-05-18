import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wond3rcard/src/analytics/views/widgets/analytics_ui_widgets.dart';
import 'package:wond3rcard/src/contact/data/controller/contact_controller.dart';
import 'package:wond3rcard/src/contact/views/pages/connection_list.dart';
import 'package:wond3rcard/src/contact/views/pages/connection_screen.dart';
import 'package:wond3rcard/src/contact/views/pages/contacts_page.dart';
import 'package:wond3rcard/src/contact/views/pages/mobile/no_connection_screen.dart';
import 'package:wond3rcard/src/contact/views/pages/mobile/no_contact_connection_screen.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';

class ConnectionDesktop extends HookConsumerWidget {
  const ConnectionDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionsNotifier = ref.watch(connectionListProvider.notifier);
    final profileNotifier = ref.read(profileProvider);
    final userId = profileNotifier.profileData?.payload.user.id ?? '';
    final contactsAsync = ref.watch(contactsControllerProvider(userId));
    final connectionsAsync = ref.watch(connectionListProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await connectionsNotifier.getConnections();
        await profileNotifier.getProfile(context);
        await ref.read(contactsControllerProvider(userId));
      });
      return null;
    }, []);

    final screens = [
      contactsAsync.when(
        data: (contacts) {
          if (contacts.isEmpty) {
            return const NoConnectionScreen();
          }
          return  ConnectionsListScreen();
        },
        loading: () => const ShimmerLoading(),
        error: (e, _) => Center(child: Text("Error loading connections: $e")),
      ),
      connectionsAsync.when(
        data: 
        (connectionsList) {
          if (connectionsList.isEmpty) {
            return const NoConnectionScreen ();
          }
          return const ConnectionMain();
        },
        loading: () => const ShimmerLoading(),
        error: (e, _) => Center(child: Text("Error loading contacts: $e")),
      ),
    ];

    return Scaffold(
     
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Connections & Contacts',
                  style: WonderCardTypography.boldTextH4(
                    color: AppColors.grayScale,
                    fontSize: 23,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectAnalytics(
                    text: 'Connections',
                    isActive: connectionsNotifier.selectedIndex == 0,
                    onTap: () {
                      connectionsNotifier.updateSelectedIndex(0);
                    },
                  ),
                  const SizedBox(width: 8),
                  SelectAnalytics(
                    icon: HeroIcons.creditCard,
                    text: 'Contacts',
                    isActive: connectionsNotifier.selectedIndex == 1,
                    onTap: () {
                      connectionsNotifier.updateSelectedIndex(1);
                    },
                  ),
                ],
              ),
              Expanded(
                child: screens[connectionsNotifier.selectedIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}
