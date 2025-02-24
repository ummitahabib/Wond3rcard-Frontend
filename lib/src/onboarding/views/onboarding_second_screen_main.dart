import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/views/pages/desktop/onboarding_second_screen_desktop.dart';
import 'package:wond3rcard/src/onboarding/views/pages/mobile/onboarding_second_screen_mobile.dart';
import 'package:wond3rcard/src/onboarding/views/pages/tablet/onboarding_second_screen_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class OnboardingSecondScreenMain extends HookConsumerWidget {
  const OnboardingSecondScreenMain({super.key});

  static const routeName = RouteString.secondScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: OnboardingSecondScreenDesktop(),
      mobile: OnboardingSecondScreenMobile(),
      tablet: OnboardingSecondScreenTablet(),
    );
  }
}
