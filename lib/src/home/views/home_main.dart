import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/home/views/pages/desktop/home_desktop.dart';
import 'package:wond3rcard/src/home/views/pages/mobile/home_mobile.dart';
import 'package:wond3rcard/src/home/views/pages/tablet/home_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class HomeMain extends HookConsumerWidget {
  const HomeMain({super.key});

  static const routeName = RouteString.home;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: HomeDesktop(),
      tablet: HomeTablet(),
      mobile: HomeMobile(),
    );
  }
}
