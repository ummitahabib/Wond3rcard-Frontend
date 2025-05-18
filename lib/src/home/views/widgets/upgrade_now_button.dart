import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/home/data/controller/home_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

Container upgradeButton(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.primaryShade,
          borderRadius: BorderRadius.circular(size25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            ImageAssets.diamond,
            width: SpacingConstants.size15,
            height: SpacingConstants.size15,
          ),
          Text('upgrade Now',
              style: WonderCardTypography.boldTextTitle2(
                  fontSize: 12, color: AppColors.defaultWhite))
        ],
      ));
}

SizedBox personalProfileButton(
    BuildContext context, HomeNotifier homeController) {
  return SizedBox(
    width: 158,
    height: SpacingConstants.size28,
    child: WonderCardButton(
        textColor: AppColors.primaryShade,
        borderRadius: BorderRadius.circular(SpacingConstants.size100),
        text: personalProfile,
        onPressed: () {},
        backgroundColor: AppColors.grayScale50,
        trailingIcon: const HeroIcon(
          HeroIcons.checkBadge,
          color: AppColors.badgeColor,
        )),
  );
}

Widget qrCodeContainer({
  HeroIcons? icon,
  Color? iconColor,
  double? iconSize,
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: 
    Container(
      padding: const EdgeInsetsDirectional.all(6.6),
      width: SpacingConstants.size40,
      height: SpacingConstants.size40,
      decoration: BoxDecoration(
        color: AppColors.grayScale50,
        borderRadius: BorderRadius.circular(
          SpacingConstants.size15,
        ),
      ),
      child: HeroIcon(
        size: iconSize ?? 18.15,
        icon ?? HeroIcons.qrCode,
        color: iconColor ?? AppColors.badgeColor,
      ),
    ),
 
 
  );
}

Widget recentConnection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size25),
        color: AppColors.defaultWhite),
    child: Container()
    //  Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     const Text(
    //       'Recent Connected',
    //       style: TextStyle(
    //         color: AppColors.grayScale500,
    //         fontFamily: 'Inter',
    //         fontSize: 12,
    //         fontWeight: FontWeight.w700,
    //       ),
    //     ),
    //     const SizedBox(
    //       height: 8,
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Expanded(
    //           child: userProfileImage(
    //           ),
    //         ),
    //         Expanded(
    //           child: Text(
    //             'ummeeta',
    //             style: WonderCardTypography.boldTextTitleBold(
    //               color: AppColors.grayScale,
    //               fontSize: SpacingConstants.size13,
    //             ),
    //           ),
    //         ),
    //          Expanded(
    //            child: HeroIcon(
    //             HeroIcons.ellipsisVertical,
    //             color: AppColors.grayScale,
    //                        ),
    //          )
    //       ],
    //     ),
    //   ],
    // ),
  );
}

Container rectangleCardWidget() {
  return Container(
    width: 341,
    height: 111,
    margin: const EdgeInsets.only(bottom: 0),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(0),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
      ),
      color: Colors.transparent.withOpacity(0),
    ),
  );
}

Container userMainContainer() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: AppColors.primaryShade,
    ),
    width: 357,
    constraints: const BoxConstraints(
      minHeight: 230,
    ),
    margin: const EdgeInsets.only(top: 75, left: 8),
    child: const Column(
      mainAxisSize: MainAxisSize.min,
      children: [],
    ),
  );
}

Container addCardWidget() {
  return Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(225),
      color: const Color(0xFFFFFFFF).withOpacity(0.4),
    ),
    child: Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white.withOpacity(0.4),
      ),
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: const Center(
              child: HeroIcon(
            HeroIcons.plus,
            color: Colors.black,
            size: 15,
          ))),
    ),
  );
}

Column connectText({
  required String text,
  Color? color,
}) {
  return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
    Text(
        textAlign: TextAlign.center,
        '$text +',
        style: TextStyle(
          color: color ?? AppColors.defaultWhite,
          fontFamily: 'Barlow',
          fontSize: 36,
          fontWeight: FontWeight.w700,
        )),
    Text(
      textAlign: TextAlign.center,
      'Connected',
      style: TextStyle(
        color: color ?? AppColors.defaultWhite,
        fontFamily: 'Barlow',
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
  ]);
}

Container personalProfileTag({String? text}) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: AppColors.grayScale50, borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Text(
            text ?? 'Personal Profile',
            style: TextStyle(
              color: AppColors.primaryShade,
              fontFamily: 'Barlow',
              fontSize: 14.475,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        HeroIcon(
          HeroIcons.checkBadge,
          color: AppColors.grayScale,
        )
      ],
    ),
  );
}

SingleChildScrollView addCardMainRowWidget(BuildContext context) {
  return SingleChildScrollView(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          fit: BoxFit.cover,
          ImageAssets.addCard,
          width: 40.0,
          height: 40.0,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: SpacingConstants.size8,
            ),
            Text('Add new card to seamlessly',
                style: TextStyle(
                    color: AppColors.grayScale,
                    fontFamily: 'Barlow',
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
            Text('share to your client',
                style: TextStyle(
                    color: AppColors.grayScale,
                    fontFamily: 'Barlow',
                    fontSize: 14,
                    fontWeight: FontWeight.w700))
          ],
        ),
        GestureDetector(
            onTap: () {
              context.go(RouteString.createNewCard);
            },
            child: addCardWidget())
      ],
    ),
  );
}

Container userProfileImage({
  double? width,
  double? height,
  double? imageWidth,
  double? imageHeight,
  String? image,
}) {
  return 
  Container(
    width: width ?? 94,
    height: height ?? 94,
    decoration: BoxDecoration(
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
        borderRadius: BorderRadius.circular(SpacingConstants.size100),
        border: Border.all(width: 4, color: AppColors.defaultWhite)),
    child: Image.network(
      image ?? ImageAssets.profile,
      fit: BoxFit.cover,
      width: imageWidth ?? 94,
      height: imageHeight ?? 94,
    ),
  );

}

Center headerContainer() {
  return Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            userMainContainer(),
          ],
        ),
        Positioned(
          left: 8,
          top: 200,
          child: Image.asset(
            ImageAssets.curve,
            fit: BoxFit.cover,
          ),
        ),
      ],
    ),
  );
}

class UserProfile {
  final String profilePhoto;
  final String name;
  final String address;

  UserProfile({
    required this.profilePhoto,
    required this.name,
    required this.address,
  });
}

final List<UserProfile> userProfiles = [
  UserProfile(
    profilePhoto: 'images/behance.png',
    name: 'Umme',
    address: 'Kaduna Nigeria',
  ),
  UserProfile(
    profilePhoto: 'images/behance.png',
    name: 'John',
    address: 'Lagos Nigeria',
  ),
  UserProfile(
    profilePhoto: 'images/behance.png',
    name: 'Jane',
    address: 'Abuja Nigeria',
  ),
];
Widget stackAvatar(List<UserProfile> userProfiles) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SizedBox(
      height: 40, 
      width: (userProfiles.length * 30.0) + 15,
      child: Stack(
        children: List.generate(userProfiles.length, (index) {
          return Positioned(
            left: index * 25.0, 
            child: ClipRRect(
              borderRadius: BorderRadius.circular(SpacingConstants.size100),
              child: Image.network(
                userProfiles[index].profilePhoto,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      ),
    ),
  );
}


class RecentConnectionWidget extends StatelessWidget {
  const RecentConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.defaultWhite,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 0, left: 15),
              child: Text(
                'Recent Connect',
                style: TextStyle(
                  color: AppColors.grayScale500,
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        userProfileImage(width: 30, height: 30),
                        Text(
                          truncateName('username$index'),
                          style: WonderCardTypography.boldTextTitleBold(
                            color: AppColors.grayScale,
                            fontSize: SpacingConstants.size13,
                          ),
                        ),
                        const HeroIcon(
                          HeroIcons.ellipsisVertical,
                          color: AppColors.grayScale,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String truncateName(String name) {
    return name.length > 6 ? '${name.substring(0, 6)}..' : name;
  }
}

class ConnectionsMedia extends HookConsumerWidget {
  const ConnectionsMedia({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.read(profileProvider);
    final profile = profileController.profileData?.payload.profile;
    final user = profileController.profileData?.payload.user;
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          if (profileController.profileData == null) {
            Future.delayed(Duration.zero, () async {
              await profileController.getProfile(context);
            });
          }
        });
        return null;
      },
      [],
    );

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size25),
                color: AppColors.defaultWhite),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                stackAvatar(userProfiles),
                Text(
                  '${profile!.connections.length}',
                  style: const TextStyle(
                    color: AppColors.grayScale,
                    fontFamily: 'Barlow',
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Active social link',
                  style: TextStyle(
                    color: AppColors.grayScale500,
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap:(){
              context.go(RouteString.userQrCode);
            },    
           child:  upgradeButton(context))
        ],
      ),
    );
  }
}
