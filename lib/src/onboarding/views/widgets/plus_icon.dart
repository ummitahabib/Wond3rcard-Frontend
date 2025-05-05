import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';

class PlusIcon extends StatelessWidget {
  const PlusIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const HeroIcon(
      HeroIcons.plus,
      color: AppColors.grayScale500,
      size: SpacingConstants.size20,
    );
  }
}
