import 'package:flutter/material.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_screen_title_widget.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _tileMethod();
  }

  Column _tileMethod() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnboardingScreenTitleText(
          text: professionalDetailsText,
        ),
        OnboardingScreenTitleText(
          text: professionalDetails2,
        ),
      ],
    );
  }
}
