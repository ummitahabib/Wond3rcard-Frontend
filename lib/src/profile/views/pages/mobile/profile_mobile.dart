import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class ProfileScreenMobile extends HookConsumerWidget {
  const ProfileScreenMobile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: WonderCardTypography.boldTextH5(
              fontSize: 23,
              color: AppColors.grayScale,
            ),
          ),
          centerTitle: true,
          leading: Container(
            padding: EdgeInsets.all(12),
            width: 40,
            height: SpacingConstants.size40,
            decoration: BoxDecoration(
                color: AppColors.defaultWhite,
                borderRadius: BorderRadius.circular(8)),
            child: SizedBox(),
          ),
        ),
        backgroundColor: AppColors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ReusableProfileHeader(),
                  Container(
                      width: 359,
                      height: 546,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          reusableRowWidget(
                              icon: HeroIcons.user,
                              onTap: () {},
                              text: 'Edit Profile'),
                          reusableRowWidget(
                            icon: HeroIcons.shieldExclamation,
                            onTap: () {},
                            text: 'Membership',
                          ),
                          reusableRowWidget(
                              icon: HeroIcons.shieldExclamation,
                              onTap: () {},
                              text: 'Privacy & security'),
                          reusableRowWidget(
                              icon: HeroIcons.shieldExclamation,
                              onTap: () {},
                              text: 'Notification'),
                          reusableRowWidget(
                              icon: HeroIcons.shieldExclamation,
                              onTap: () {},
                              text: 'Help & Support'),
                          reusableRowWidget(
                            icon: HeroIcons.shieldExclamation,
                            onTap: () {},
                            text: 'Terms and Condition',
                          ),
                          reusableRowWidget(
                              icon: HeroIcons.shieldExclamation,
                              onTap: () {},
                              text: 'Q & A'),
                          reusableRowWidget(
                              icon: HeroIcons.shieldExclamation,
                              onTap: () {},
                              text: 'Logout'),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}

class ReusableProfileHeader extends StatelessWidget {
  const ReusableProfileHeader({
    super.key,
  });

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
              'Premium',
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
                'Muhd Garba Wudil',
                style: TextStyle(
                  fontFamily: 'Barlow',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                'ameerwudil@gmail.com',
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

Container reusableRowWidget(
    {Widget? widget,
    required HeroIcons icon,
    required String text,
    required void Function() onTap}) {
  return Container(
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
        GestureDetector(
            onTap: onTap,
            child: widget ??
                HeroIcon(
                  HeroIcons.arrowRight,
                  size: 18.67,
                  color: AppColors.grayScale700,
                ))
      ],
    ),
  );
}
