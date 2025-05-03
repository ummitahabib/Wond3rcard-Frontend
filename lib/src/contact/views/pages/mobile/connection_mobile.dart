import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/views/widgets/analytics_ui_widgets.dart';
import 'package:wond3rcard/src/contact/data/controller/contact_controller.dart';
import 'package:wond3rcard/src/contact/views/pages/connection_list.dart';
import 'package:wond3rcard/src/contact/views/pages/contacts_page.dart';
import 'package:wond3rcard/src/contact/views/pages/mobile/contact_mobile.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';


class ConnectionMobile extends HookConsumerWidget {
  const ConnectionMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connections = ref.watch(connectionListProvider.notifier);
 final contactsAsync = ref.watch(contactsControllerProvider('67ae134c1926fbabef30d9a3'));
   final profile = ref.read(profileProvider);
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final connections = ref.read(connectionListProvider.notifier);
           Future.delayed(Duration.zero, () async {
              await connections.getConnections();
              await ref.read(profileProvider).getProfile(context);
              await ref.read(contactsControllerProvider('67ae134c1926fbabef30d9a3'));
           
            }
            
            );
        });
        return null;
      },
      [],
    );

    final screens = [
      ContactsPage(userId: '67ae134c1926fbabef30d9a3'),
      const Center(child: ConnectionsListScreen()),
      
    ];

    return SafeArea(
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
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SelectAnalytics(
                  text: 'Connections',
                  isActive: connections.selectedIndex == 0,
                  onTap: () {
                    connections.updateSelectedIndex(0);
                  },
                ),
                const SizedBox(width: 8),
                SelectAnalytics(
                  icon: HeroIcons.creditCard,
                  text: 'Contacts',
                  isActive: connections.selectedIndex == 1,
                  onTap: () {
                    connections.updateSelectedIndex(1);
                  },
                ),
              ],
            ),
            Expanded(
              child: screens[connections.selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}
