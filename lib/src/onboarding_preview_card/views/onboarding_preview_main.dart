import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding_preview_card/views/pages/desktop/onboarding_preview_card_desktop.dart';
import 'package:wond3rcard/src/onboarding_preview_card/views/pages/mobile/onboarding_preview_card_mobile.dart';
import 'package:wond3rcard/src/onboarding_preview_card/views/pages/tablet/onboarding_preview_card_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class OnboardingPreviewMain extends HookConsumerWidget {
  const OnboardingPreviewMain({super.key});

  static const routeName = RouteString.previewCard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: OnboardingPreviewDesktop(),
      mobile: OnboardingPreviewMobile(),
      tablet: OnboardingPreviewTablet(),
    );
  }
}
