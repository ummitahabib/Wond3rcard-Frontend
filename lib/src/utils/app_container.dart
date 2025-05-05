import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    required this.child,
    this.width,
    this.padding,
    this.color,
    this.radius,
    this.height,
  });
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? radius;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.all(
            SpacingConstants.size20,
          ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayScale400),
        borderRadius: BorderRadius.circular(radius ?? SpacingConstants.size10),
        color: color ?? AppColors.defaultWhite,
      ),
      height: height,
      width: width,
      child: child,
    );
  }
}
