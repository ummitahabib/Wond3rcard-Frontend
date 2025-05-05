import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';

class AppIcons {
  static const HeroIcon checkCircle = HeroIcon(
    HeroIcons.checkCircle,
    style: HeroIconStyle.outline,
    color: AppColors.green,
    size: SpacingConstants.size30,
  );

  static const HeroIcon cancel = HeroIcon(
    HeroIcons.check,
    style: HeroIconStyle.outline,
    color: AppColors.green,
    size: SpacingConstants.size30,
  );

  static const HeroIcon iconOff = HeroIcon(
    HeroIcons.eye,
    style: HeroIconStyle.outline,
    color: AppColors.grayScale500,
    size: SpacingConstants.size30,
  );

  static const HeroIcon iconOn = HeroIcon(
    HeroIcons.eyeSlash,
    style: HeroIconStyle.outline,
    color: AppColors.grayScale500,
    size: SpacingConstants.size30,
  );
}
