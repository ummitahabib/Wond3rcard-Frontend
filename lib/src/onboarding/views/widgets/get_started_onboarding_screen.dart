import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/views/pages/desktop/get_started_onbordind_desktop.dart';
import 'package:wond3rcard/src/onboarding/views/pages/mobile/get_started_onboarding_mobile.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class GetStartedOnboardingScreenMain extends HookConsumerWidget {
  const GetStartedOnboardingScreenMain({super.key});

  static const routeName = RouteString.home;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: GetStartedOnboardingScreenDesktop(),
      tablet: GetStartedOnboardingScreenMobile(),
      mobile: GetStartedOnboardingScreenMobile(),
    );
  }
}
