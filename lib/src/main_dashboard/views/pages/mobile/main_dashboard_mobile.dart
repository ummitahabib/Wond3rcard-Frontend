import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/views/pages/analytics_main_page.dart';
import 'package:wond3rcard/src/cards/views/pages/cards_main.dart';
import 'package:wond3rcard/src/home/data/controller/home_controller.dart';
import 'package:wond3rcard/src/home/views/home_main.dart';
import 'package:wond3rcard/src/home/views/widgets/bottom_nav.dart';
import 'package:wond3rcard/src/profile/views/profile.dart';
import 'package:wond3rcard/src/qr_code/views/widgets/share_card_list.dart';

class MainDashboardMobile extends HookConsumerWidget {
  const MainDashboardMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeController = ref.watch(homeProvider);

    return Scaffold(
      body: _homeBodyMobile(homeController),
      bottomNavigationBar: bottomNav(context, homeController),
    );
  }

  IndexedStack _homeBodyMobile(HomeNotifier homeController) {
    return IndexedStack(
      index: homeController.activeIndex,
      children: [
        const HomeMain(),
        const CardsMain(),
        ShareCardList(),
        //ShareQrWidget(),
        const AnalyticsMainPage(),
        ProfileMainScreen(),
      ],
    );
  }
}
