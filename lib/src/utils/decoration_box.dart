import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/utils/app_icons.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';

class DecorationBox {
  static OutlineInputBorder customOutlineBorderSideAndRadius(
      {required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(SpacingConstants.size8),
    );
  }

  static HeroIcon validIcon() {
    return AppIcons.checkCircle;
  }

  static HeroIcon cancelIcon() {
    return AppIcons.cancel;
  }

  static HeroIcon passwordIconOn() {
    return AppIcons.iconOn;
  }

  static HeroIcon passwordIconOff() {
    return AppIcons.iconOff;
  }

  static OutlineInputBorder customOutlineBorder({
    Color? color,
    double? width,
  }) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color ?? AppColors.grayScale200,
        width: width ?? SpacingConstants.size1point5,
      ),
    );
  }

  static BoxDecoration detailContainerDecorationBox() {
    return BoxDecoration(
      color: AppColors.defaultWhite,
      borderRadius: BorderRadius.circular(SpacingConstants.size12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0F000000),
          offset: Offset(
            SpacingConstants.size0,
            SpacingConstants.size1,
          ),
          blurRadius: SpacingConstants.size2,
        ),
        BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(
            SpacingConstants.size0,
            SpacingConstants.size1,
          ),
          blurRadius: SpacingConstants.size3,
        ),
      ],
    );
  }

  static BoxDecoration getStartedDecorationBox() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(119, 69, 221, 0),
          Color(0xFF402577),
        ],
      ),
    );
  }

  static Radius radius() => const Radius.circular(size29point38);
  static BoxDecoration bottomNavBoxDecoration() {
    return 
    BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            offset: Offset(
              SpacingConstants.size1,
              SpacingConstants.size5,
            ),
            blurRadius: size47point8,
          )
        ],
        color: AppColors.transparent,
        borderRadius: BorderRadius.horizontal(
          left: radius(),
          right: radius(),
        ));
  
  }

  static BoxDecoration cardBoxDecoration({Color? color}) {
    return BoxDecoration(
      color: color ?? AppColors.grayScale50,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(SpacingConstants.size20),
        topRight: Radius.circular(SpacingConstants.size20),
      ),
    );
  }
}
