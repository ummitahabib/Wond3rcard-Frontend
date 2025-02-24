import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class ResponsiveButton extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String text;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final Color? leadingIconColor;
  final Color? trailingIconColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Size? minimumSize;
  final double? iconSize;

  const ResponsiveButton({
    super.key,
    this.leadingIcon,
    this.trailingIcon,
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    this.leadingIconColor,
    this.trailingIconColor,
    this.textStyle,
    this.padding,
    this.borderRadius,
    this.minimumSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(
          buttonColor ?? AppColors.primaryShade,
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          padding ?? const EdgeInsets.all(SpacingConstants.size10),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? SpacingConstants.size8),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          minimumSize ??
              const Size(SpacingConstants.size160, SpacingConstants.size44),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          textStyle ??
              WonderCardTypography.hintTextSytle(
                color: textColor ?? AppColors.hintTextColor,
                fontSize: SpacingConstants.size14,
              ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            Icon(
              leadingIcon,
              size: iconSize ?? SpacingConstants.size20,
              color: leadingIconColor ?? AppColors.primaryShade,
            ),
            const SizedBox(width: SpacingConstants.size8),
          ],
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: textStyle?.copyWith(color: textColor) ??
                  WonderCardTypography.hintTextSytle(
                    color: textColor ?? AppColors.hintTextColor,
                    fontSize: SpacingConstants.size14,
                  ),
            ),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: SpacingConstants.size8),
            Icon(
              trailingIcon,
              size: iconSize ?? SpacingConstants.size20,
              color: trailingIconColor ?? AppColors.grayScale,
            ),
          ],
        ],
      ),
    );
  }
}
