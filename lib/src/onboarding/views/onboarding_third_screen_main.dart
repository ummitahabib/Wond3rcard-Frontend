import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/views/pages/desktop/onboarding_third_screen_desktop.dart';
import 'package:wond3rcard/src/onboarding/views/pages/mobile/onboarding_third_screen_mobile.dart';
import 'package:wond3rcard/src/onboarding/views/pages/tablet/onboarding_third_screen_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class OnboardingThirdScreenMain extends HookConsumerWidget {
  const OnboardingThirdScreenMain({super.key});

  static const routeName = RouteString.thirdScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: OnboardingThirdScreenDesktop(),
      mobile: OnboardingThirdScreenMobile(),
      tablet: OnboardingThirdScreenTablet(),
    );
  }
}
