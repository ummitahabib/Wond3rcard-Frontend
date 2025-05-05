import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';

class ContinueWidget extends StatelessWidget {
  const ContinueWidget({
    super.key,
    this.bgColor,
    this.textColor,
    this.buttonText,
    required this.onPress,
    this.showLoader,
    this.onTap,
  });

  final Color? bgColor;
  final Color? textColor;
  final String? buttonText;
  final void Function() onPress;
  final bool? showLoader;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: onTap ??
              () {
                GoRouter.of(context).pop();
              },
          child: const ArrowLeftIcon(),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: SizedBox(
            height: SpacingConstants.size52,
            child: _continueButton(context),
          ),
        ),
      ],
    );
  }

  WonderCardButton _continueButton(BuildContext context) {
    return WonderCardButton(
        showLoader: showLoader ?? false,
        textColor: textColor ?? AppColors.grayScale500,
        backgroundColor: bgColor ?? AppColors.grayScale200,
        text: buttonText ?? continueText,
        onPressed: onPress);
  }
}

class ArrowLeftIcon extends StatelessWidget {
  const ArrowLeftIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryShade,
        borderRadius: BorderRadius.circular(SpacingConstants.size8),
      ),
      width: SpacingConstants.size65,
      height: SpacingConstants.size52,
      child: const HeroIcon(
        HeroIcons.arrowLeft,
        color: AppColors.defaultWhite,
        size: SpacingConstants.size28,
      ),
    );
  }
}
