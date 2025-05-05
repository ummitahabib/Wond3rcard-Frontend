import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class WonderCardTextButton extends StatelessWidget {
  const WonderCardTextButton({
    super.key,
    required this.text,
    this.color,
    this.onPressed,
  });

  final String text;
  final Color? color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: WonderCardTypography.regularTextTitle2Bold(
              color: color ?? AppColors.grayScale600,
              fontSize: SpacingConstants.size16),
        ));
  }
}
