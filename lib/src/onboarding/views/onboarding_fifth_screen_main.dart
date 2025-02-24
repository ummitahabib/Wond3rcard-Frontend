import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/views/pages/desktop/onboarding_fifth_screen_desktop.dart';
import 'package:wond3rcard/src/onboarding/views/pages/mobile/onboarding_fifth_screen_mobile.dart';
import 'package:wond3rcard/src/onboarding/views/pages/tablet/onboarding_fifth_screen_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class OnboardingFifthScreenMain extends HookConsumerWidget {
  const OnboardingFifthScreenMain({super.key});

  static const routeName = RouteString.fifthScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: OnboardingFifthScreenDesktop(),
      mobile: OnboardingFifthScreenMobile(),
      tablet: OnboardingFifthScreenTablet(),
    );
  }
}
