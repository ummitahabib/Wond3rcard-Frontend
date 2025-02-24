import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/get_started_bg.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';

class GetStartedOnboardingScreen extends HookConsumerWidget {
  const GetStartedOnboardingScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(body: _getStartedStack(context));
  }

  Stack _getStartedStack(BuildContext context) {
    return Stack(
      children: [
        const GetStartedBg(),
        Stack(
          children: [
            Image.asset(ImageAssets.splashScreenFrame1),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(ImageAssets.splashScreenIllustration),
            ),
            Padding(
              padding: const EdgeInsets.all(
                SpacingConstants.size30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(AppStrings.getStartedDescription1,
                          textAlign: TextAlign.center,
                          style: WonderCardTypography.boldTextH4()),
                      Text(AppStrings.getStartedDescription2,
                          textAlign: TextAlign.center,
                          style: WonderCardTypography.boldTextH4()),
                      Text(AppStrings.getStartedDescription3,
                          textAlign: TextAlign.center,
                          style: WonderCardTypography.boldTextH4()),
                    ],
                  ),
                  const SizedBox(height: SpacingConstants.size15),
                  Center(
                    child: WonderCardButton(
                      buttonTextType: ButtonTextType.withForwardArrow,
                      text: AppStrings.getStarted,
                      textColor: AppColors.primaryShade,
                      onPressed: () => context.go(RouteString.firstScreen),
                      backgroundColor: AppColors.defaultWhite,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
