import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/custom_app_bar.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/back_navigator.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

//Todo rework on this file and break the widgets and method into smaller parts
class ShareQrWidget extends HookConsumerWidget {
  const ShareQrWidget({super.key});

  static const routeName = RouteString.shareCardLink;

  final String appDeepLink = "wond3rcard://user-card";
  final String appStoreLink =
      "https://play.google.com/store/apps/details?id=com.example.yourapp";

  String getQRCodeUrl() {
    //firebase dynamic link or other deeplink services
    return "https://yourdomain.com/redirect?deepLink=$appDeepLink&storeLink=$appStoreLink";
  }

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
              await profileController.getProfile();
            });
          }
        });
        return null;
      },
      [],
    );

    return Scaffold(
      backgroundColor: AppColors.primaryShade,
      appBar: CustomAppBar(
        
        leading:  BackNavigator(
          onPress: () => context.go('/'),
        ), title: 'Share'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                width: 327,
                padding: const EdgeInsets.symmetric(
                  vertical: 56,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    SpacingConstants.size16,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    userProfileImage(),
                    Text(
                      '${profile?.firstname ?? emptyString} ${profile?.lastname ?? emptyString}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: wonderCardFontName,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: DashedBorder.all(
                          color: AppColors.primaryShade,
                          dashLength: 40,
                          width: 2,
                          isOnlyCorner: true,
                          strokeAlign: BorderSide.strokeAlignInside,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      child: QrImageView(
                        data: getQRCodeUrl(),
                        version: QrVersions.auto,
                        size: 229,
                        gapless: false,
                        errorStateBuilder: (cxt, err) {
                          return Container(
                            child: const Center(
                              child: Text(
                                'Uh oh! Something went wrong...',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(18),
                      width: 229,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primaryShade,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                          child: Text('Preview Card',
                              style: TextStyle(color: AppColors.defaultWhite))),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  linkContainer('Copy link', HeroIcons.link, () {}),
                  linkContainer('Share link', HeroIcons.arrowUpTray, () {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector linkContainer(
    String text,
    HeroIcons icon,
    Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 158.5,
        height: 61.59,
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.defaultWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontFamily: wonderCardFontName,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            HeroIcon(
              icon,
              color: AppColors.grayScale700,
            )
          ],
        ),
      ),
    );
  }
}

Container chooseCardToShare() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 23),
    width: 406,
    height: 657,
    decoration: const BoxDecoration(
      color: AppColors.grayScale50,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: const Column(
      children: [
        SearchField(),
        SizedBox(
          height: SpacingConstants.size40,
        ),

        // this will be generated as list to get all available cards
        CustomRowContainer(),
      ],
    ),
  );
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360, // Fixed width
      height: 51, // Fixed height
      padding: const EdgeInsets.fromLTRB(16, 0, 14, 0), // Padding
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2), // Adjust opacity
        borderRadius: BorderRadius.circular(8), // Rounded corners (optional)
        border: Border.all(color: Colors.grey.shade400), // Border color
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey), // Search Icon
          SizedBox(width: 10), // Gap between icon and text field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none, // Remove underline
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRowContainer extends StatelessWidget {
  const CustomRowContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 72,
      constraints: const BoxConstraints(minHeight: 72),
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userProfileImage(
            height: 60,
            width: 60,
          ),
          const Text(
            'Card name',
            style: TextStyle(
                fontFamily: wonderCardFontName,
                fontSize: 23,
                fontWeight: FontWeight.w700,
                color: AppColors.grayScale700),
          ),
          // to do if card is selected check the circle else uncheck
          const Icon(
            Icons.circle_outlined,
            color: AppColors.primaryShade,
          )
        ],
      ),
    );
  }
}
