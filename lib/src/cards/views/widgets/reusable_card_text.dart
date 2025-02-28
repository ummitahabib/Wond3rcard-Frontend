import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

Text reusableCardText({double? fontSize, String? text}) {
  return Text(
    textAlign: TextAlign.left,
    text ?? 'Image & Layout',
    style: WonderCardTypography.boldTextTitleBold(
        color: AppColors.grayScale, fontSize: fontSize ?? 18),
  );
}