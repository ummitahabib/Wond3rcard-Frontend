import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/views/pages/desktop/onboarding_first_screen_desktop.dart';
import 'package:wond3rcard/src/onboarding/views/pages/mobile/onboarding_first_screen_mobile.dart';
import 'package:wond3rcard/src/onboarding/views/pages/tablet/onboarding_first_screen_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class OnboardingMainScreen extends HookConsumerWidget {
  const OnboardingMainScreen({super.key});

  static const routeName = RouteString.firstScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: OnboardingFirstScreenDesktop(),
      mobile: OnboardingFirstScreenMobile(),
      tablet: OnboardingFirstScreenTablet(),
    );
  }
}
