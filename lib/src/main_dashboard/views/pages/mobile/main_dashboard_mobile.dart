import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/views/pages/analytics_main_page.dart';
import 'package:wond3rcard/src/cards/views/pages/cards_main.dart';
import 'package:wond3rcard/src/contact/views/pages/connection_screen.dart';
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
      body: _buildPage(homeController.activeIndex),
      bottomNavigationBar: bottomNav(context, homeController),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const SafeArea(child: HomeMain());
      case 1:
        return const SafeArea(child: CardsMain());
      case 2:
        return  SafeArea(child: ShareCardList());
              case 3:
        return  SafeArea(child: ConnectionMain());
      case 4:
        return const SafeArea(child: AnalyticsMainPage());
      case 5:
        return const SafeArea(child: ProfileMainScreen());
      default:
        return const Center(child: Text("Page not found"));
    }
  }
}
