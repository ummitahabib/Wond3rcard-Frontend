import 'package:flutter/material.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_screen_title_widget.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

Column onboardingTitle(String text1, String text2) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      OnboardingScreenTitleText(
        text: text1,
      ),
      OnboardingScreenTitleText(
        text: text2,
      ),
    ],
  );
}


  Widget getStartedStack(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          ImageAssets.bgBlur,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Image.asset(
            ImageAssets.wonderCardLogo,
            width: 120,
            height: 120,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(
            SpacingConstants.size30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(ImageAssets.splashScreenIllustration),
              ),
              Spacer(),
              Text(
                  softWrap: true,
                  '${AppStrings.getStartedDescription1} ${AppStrings.getStartedDescription2} ${AppStrings.getStartedDescription3}',
                  textAlign: TextAlign.start,
                  style: WonderCardTypography.boldTextH4()),
              const SizedBox(height: SpacingConstants.size15),
            ],
          ),
        ),
      ],
    );
  }

