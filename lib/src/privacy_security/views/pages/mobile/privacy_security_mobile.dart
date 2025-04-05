import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_model/profile.dart';
import 'package:wond3rcard/src/profile/views/pages/mobile/profile_mobile.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class PrivacySecurityScreenMobile extends HookConsumerWidget {
  const PrivacySecurityScreenMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
       final adminUserController = ref.read(profileProvider);
    
        useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final adminUserController = ref.read(profileProvider);
         
            Future.delayed(Duration.zero, () async {
              await adminUserController.getProfile(context);
            });
          
        });
        return null;
      },
      [],
    );
    return Scaffold(appBar: _appBar(), body: _body(adminUserController.profileData!));
  }

    Widget _body(UserProfileResponse profile) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ReusableProfileHeader(profile: profile,),
          SizedBox(height: 30,),
          Container(
              width: size355,
              height: 400,
              decoration: BoxDecoration(
                  color: AppColors.defaultWhite,
                  borderRadius: BorderRadius.circular(size25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  reusableRowWidget(
                    icon: HeroIcons.shieldExclamation,
                    onTap: () {},
                    text: twoFactorAuthText,
                  ),
                  SizedBox(height: 10,),
                  reusableRowWidget(
                    icon: HeroIcons.shieldExclamation,
                    onTap: () {},
                    text: multiFactorAuthText,
                  ),
                     SizedBox(height: 10,),
                  reusableRowWidget(
                    icon: HeroIcons.shieldExclamation,
                    onTap: () {},
                    text: changePasswordText,
                  ),
                     SizedBox(height: 10,),
                  reusableRowWidget(
                    icon: HeroIcons.trash,
                    onTap: () {},
                    text: deleteAccountText,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title:  Text(
          privacyAndSecurityText,
          style: WonderCardTypography.boldTextH5(
            fontSize: SpacingConstants.size15,
            color: AppColors.grayScale,
          ),
        ),
      centerTitle: true,
      leading: reusableBackIcon(),
     
    );
  }


}


  Container reusableBackIcon() {
    return Container(
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
    );
  }