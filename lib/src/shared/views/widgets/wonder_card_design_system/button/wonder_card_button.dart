import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/media_query_size.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

enum ButtonVariant { primary, secondary, outline }

enum ButtonState { enable, disable }

enum ButtonTextType { normal, withaddIcon, withForwardArrow }

class WonderCardButton extends StatelessWidget {
  final String text;
  final ButtonState state;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final double? buttonWidth;
  final Widget? buttonWidget;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool showLoader;
  final ButtonTextType buttonTextType;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  final Color? loadererColor;
  final BorderRadiusGeometry? borderRadius;
  const WonderCardButton({
    super.key,
    required this.text,
    this.buttonWidth,
    this.leadingIcon,
    this.trailingIcon,
    this.showLoader = false,
    this.buttonWidget,
    this.backgroundColor,
    this.loadererColor = AppColors.defaultWhite,
    this.textColor,
    this.borderColor,
    this.buttonTextType = ButtonTextType.normal,
    this.state = ButtonState.enable,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Color newBackgroundColor;
    Color newTextColor;
    Color newBorderColor;
    switch (state) {
      case ButtonState.enable:
        newBackgroundColor = variant != ButtonVariant.primary
            ? backgroundColor ?? AppColors.defaultWhite
            : backgroundColor ?? AppColors.primaryShade800;
        newTextColor = textColor ?? AppColors.grayScale800;
        newBorderColor = borderColor ?? AppColors.primaryShade800;
      case ButtonState.disable:
        newBackgroundColor = variant != ButtonVariant.primary
            ? backgroundColor ?? AppColors.defaultWhite
            : backgroundColor ?? AppColors.grayScale50;
        newTextColor = textColor ?? AppColors.grayScale400;
        newBorderColor = borderColor ?? AppColors.grayScale200;
        break;
    }

    getButtonTextWidget() {
      switch (buttonTextType) {
        case ButtonTextType.normal:
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              leadingIcon ?? const SizedBox(),
              Text(
                text,
                style: WonderCardTypography.hintTextSytle(
                  color: newTextColor,
                ),
              ),
              trailingIcon ?? const SizedBox(),
            ],
          );
        case ButtonTextType.withaddIcon:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: SpacingConstants.size20,
                color: newTextColor,
              ),
              const SizedBox(
                width: SpacingConstants.size5,
              ),
              Text(
                text,
                style: WonderCardTypography.hintTextSytle(
                  color: newTextColor,
                ),
              ),
            ],
          );
        case ButtonTextType.withForwardArrow:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: WonderCardTypography.boldTextH5(
                  color: newTextColor,
                ),
              ),
              const SizedBox(
                width: SpacingConstants.size10,
              ),
              Icon(
                Icons.arrow_forward,
                size: size20,
                color: newTextColor,
              ),
            ],
          );
      }
    }

    Widget handlebuttonChildWidget() {
      if (showLoader) {
        return Center(
          child: SizedBox(
            width: SpacingConstants.size20,
            height: SpacingConstants.size20,
            child: CircularProgressIndicator(
              strokeWidth: SpacingConstants.size2,
              color: loadererColor,
            ),
          ),
        );
      } else {
        return buttonWidget ?? getButtonTextWidget();
      }
    }

    return ElevatedButton(
      onPressed: () {
        if (showLoader) {
        } else {
          onPressed();
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: SpacingConstants.size0,
        backgroundColor: newBackgroundColor,
        foregroundColor: newTextColor,
        // fixedSize: Size(
        //     buttonWidth ??
        //         getScreenSize(context).width * SpacingConstants.size0point08,
        //     SpacingConstants.size47),
        side: variant != ButtonVariant.primary
            ? BorderSide(color: newBorderColor, width: SpacingConstants.size2)
            : BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadius ?? BorderRadius.circular(SpacingConstants.size8),
        ),
      ),
      child: handlebuttonChildWidget(),
    );
  }
}
