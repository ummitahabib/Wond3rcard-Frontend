import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.onTap,
    this.buttontext = emptyString,
    this.sizedimensionwidth,
    this.sizedimensionheight,
    this.alignGeometry,
    this.textcolor,
    this.padding,
    this.textstyle,
    this.textWeight,
    this.underLineText = false,
    super.key,
    this.textsize,
  });
  final String buttontext;
  final Function() onTap;
  final Color? textcolor;
  final TextStyle? textstyle;
  final double? textsize;
  final double? sizedimensionheight;
  final double? sizedimensionwidth;
  final EdgeInsets? padding;
  final AlignmentGeometry? alignGeometry;
  final FontWeight? textWeight;
  final bool underLineText;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        minimumSize: Size(
          sizedimensionwidth ?? SpacingConstants.size30,
          sizedimensionheight ?? SpacingConstants.size30,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: alignGeometry ?? Alignment.centerLeft,
      ),
      child: Padding(
        padding: const EdgeInsets.all(SpacingConstants.size2),
        child: Text(
          buttontext,
          style: textstyle ??
              WonderCardTypography.regularTextTitle2Bold(
                color: textcolor ?? AppColors.primaryShade,
              ).copyWith(
                decoration: underLineText ? TextDecoration.underline : null,
                decorationColor: textcolor ?? AppColors.primaryShade,
              ),
        ),
      ),
    );
  }
}
