import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/main_dashboard/views/pages/desktop/main_dashboard_desktop.dart';
import 'package:wond3rcard/src/main_dashboard/views/pages/mobile/main_dashboard_mobile.dart';
import 'package:wond3rcard/src/main_dashboard/views/pages/tablet/main_dashboard_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class MainDashboard extends HookConsumerWidget {
  const MainDashboard({super.key});

  static const routeName = RouteString.mainDashboard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: MainDashboardDesktop(),
      tablet: MainDashboardTablet(),
      mobile: MainDashboardMobile(),
    );
  }
}
