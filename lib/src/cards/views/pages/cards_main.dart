import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/cards/views/pages/desktop/cards_desktop.dart';
import 'package:wond3rcard/src/cards/views/pages/mobile/cards_mobile.dart';
import 'package:wond3rcard/src/cards/views/pages/tablet/cards_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class CardsMain extends HookConsumerWidget {
  const CardsMain({super.key});

  static const String routeName = RouteString.cardMain;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: CardsDesktop(),
      tablet: CardsTablet(),
      mobile: CardsMobile(),
    );
  }
}
