import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/profile/views/pages/mobile/profile_mobile.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class PrivacySecurityScreenMobile extends HookConsumerWidget {
  const PrivacySecurityScreenMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(appBar: _appBar(), body: _body());
  }

  Column _body() {
    return Column(
      children: [
        ReusableProfileHeader(),
        Container(
            width: size355,
            height: size308,
            decoration: BoxDecoration(
                color: AppColors.defaultWhite,
                borderRadius: BorderRadius.circular(size25)),
            child: Column(
              children: [
                reusableRowWidget(
                  icon: HeroIcons.shieldExclamation,
                  onTap: () {},
                  text: twoFactorAuthText,
                ),
                reusableRowWidget(
                  icon: HeroIcons.shieldExclamation,
                  onTap: () {},
                  text: multiFactorAuthText,
                ),
                reusableRowWidget(
                  icon: HeroIcons.shieldExclamation,
                  onTap: () {},
                  text: changePasswordText,
                ),
                reusableRowWidget(
                  icon: HeroIcons.trash,
                  onTap: () {},
                  text: deleteAccountText,
                ),
              ],
            )),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: Container(
        width: size40,
        height: SpacingConstants.size40,
        decoration: BoxDecoration(
            color: AppColors.defaultWhite,
            borderRadius: BorderRadius.circular(size8)),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.grayScale,
          ),
        ),
      ),
      actions: [
        Text(
          privacyAndSecurityText,
          style: WonderCardTypography.boldTextH5(
            fontSize: SpacingConstants.size23,
            color: AppColors.grayScale,
          ),
        )
      ],
    );
  }
}
