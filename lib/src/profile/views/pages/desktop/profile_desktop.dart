import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/pages/desktop/admin_dashboard_desktop.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/authentication/views/authentication/login/views/pages/login_main.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_model/profile.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class ProfileScreenDesktop extends HookConsumerWidget {
  const ProfileScreenDesktop({super.key});
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

    void _showLogoutDialog(BuildContext context, WidgetRef ref) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Confirm Logout"),
            content: const Text("Are you sure you want to logout?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  await StorageUtil.putString(
                    key: SessionString.accessTokenString,
                    value: AppStrings.emptyString,
                  );
                  context.go(RouteString.logIn);
                  Navigator.of(ctx).pop();
                  await ref.read(logoutControllerProvider.notifier).logout();

                  if (context.mounted) {
                    context.go(RouteString.logIn);
                  }
                },
                child: const Text("Yes, Logout",
                    style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        backgroundColor: AppColors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ReusableProfileHeader(
                  profile: userProfile.profileData!,
                ),
                Container(
                    height: 546,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        reusableRowWidget(
                            icon: HeroIcons.user,
                            onTap: () {
                              context.go(RouteString.editProfile);
                            },
                            text: 'Edit Profile'),
                        reusableRowWidget(
                          icon: HeroIcons.shieldExclamation,
                          onTap: () {
                            context.go(RouteString.memebershipSubscription);
                          },
                          text: 'Membership',
                        ),
                        reusableRowWidget(
                            icon: HeroIcons.shieldExclamation,
                            onTap: () {
                              context.go(RouteString.privacySecurity);
                            },
                            text: 'Privacy & security'),
                        reusableRowWidget(
                            icon: HeroIcons.shieldExclamation,
                            onTap: () {},
                            text: 'Notification'),
                        reusableRowWidget(
                            icon: HeroIcons.shieldExclamation,
                            onTap: () {
                              context.go(RouteString.helpAndSupport);
                            },
                            text: 'Help & Support'),
                        reusableRowWidget(
                          icon: HeroIcons.shieldExclamation,
                          onTap: () {
                            context.go(RouteString.termsAndCondition);
                          },
                          text: 'Terms and Condition',
                        ),
                        reusableRowWidget(
                            icon: HeroIcons.shieldExclamation,
                            onTap: () {
                              context.go(RouteString.qAndA);
                            },
                            text: 'Q & A'),
                        reusableRowWidget(
                            icon: HeroIcons.shieldExclamation,
                            onTap: () => _showLogoutDialog(context, ref),
                            text: 'Logout'),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}

class ReusableProfileHeader extends StatelessWidget {
  const ReusableProfileHeader({
    super.key,
    required this.profile,
  });

  final UserProfileResponse profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 357,
      height: 230,
      decoration: BoxDecoration(
        color: AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(ImageAssets.profileBg)),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            width: 63,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.alert,
              borderRadius: BorderRadius.circular(54),
            ),
            child: Text(
              textAlign: TextAlign.center,
              profile.payload.user.userTier.plan,
              //userType,
              style: TextStyle(
                fontFamily: 'Barlow',
                fontSize: 8.59,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                "${profile.payload.profile.firstname} ${profile.payload.profile.lastname}",
                style: TextStyle(
                  fontFamily: 'Barlow',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "${profile.payload.profile.email}",
                style: TextStyle(
                  fontFamily: 'Barlow',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget reusableRowWidget(
    {Widget? widget,
    required HeroIcons icon,
    required String text,
    required void Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      width: 335,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Color(0xffE0E0E0)),
        color: AppColors.grayScale50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HeroIcon(
            icon,
            size: 18.67,
            color: AppColors.grayScale700,
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            text,
            style: WonderCardTypography.boldTextTitle2(
              fontSize: 16,
              color: AppColors.grayScale700,
            ),
          ),
          Spacer(),
          widget ??
              HeroIcon(
                HeroIcons.arrowRight,
                size: 18.67,
                color: AppColors.grayScale700,
              )
        ],
      ),
    ),
  );
}
