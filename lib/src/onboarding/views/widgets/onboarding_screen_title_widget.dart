import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class OnboardingScreenTitleText extends StatelessWidget {
  const OnboardingScreenTitleText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: WonderCardTypography.boldTextH4(
          fontSize: SpacingConstants.size28, color: AppColors.grayScale),
    );
  }
}
