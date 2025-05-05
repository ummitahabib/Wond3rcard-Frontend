import 'package:flutter/material.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_screen_title_widget.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class OnboardingThirdScreenTextDetails extends StatelessWidget {
  const OnboardingThirdScreenTextDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        OnboardingScreenTitleText(
          text: whatProfessionalDetailsText,
        ),
        OnboardingScreenTitleText(
          text: whatProfessionalDetailsText2,
        ),
      ],
    );
  }
}
