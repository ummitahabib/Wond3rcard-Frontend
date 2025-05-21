import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_model/profile.dart';
import 'package:wond3rcard/src/profile/views/pages/mobile/profile_mobile.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class PrivacySecurityScreenDesktop extends HookConsumerWidget {
  const PrivacySecurityScreenDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.read(profileProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final userProfile = ref.read(profileProvider);

          Future.delayed(Duration.zero, () async {
            await userProfile.getProfile(context);
          });
        });
        return null;
      },
      [],
    );
    return Scaffold(
      appBar: _appBar(context),
      body: _body(userProfile.profileData!, context),
    );
  }

  Widget _body(UserProfileResponse profile, BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
              child: ReusableProfileHeader(
            profile: profile,
          )),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
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
                      onTap: () {
                        context.go(RouteString.twoFAuth);
                      },
                      text: twoFactorAuthText,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    reusableRowWidget(
                      icon: HeroIcons.shieldExclamation,
                      onTap: () {},
                      text: multiFactorAuthText,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    reusableRowWidget(
                      icon: HeroIcons.shieldExclamation,
                      onTap: () {
                        context.go(RouteString.changePassword);
                      },
                      text: changePasswordText,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    reusableRowWidget(
                      icon: HeroIcons.trash,
                      onTap: () {
                        context.go(RouteString.deleteAccount);
                      },
                      text: deleteAccountText,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          context.go(
            RouteString.profile,
          );
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColors.grayScale,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Privacy & Security',
            style: WonderCardTypography.boldTextH5(
              fontSize: 23,
              color: AppColors.grayScale,
            ),
          ),
        )
      ],
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
