import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/admin/social_media/data/controller/social_media_controller.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/behance_avatar.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/preview_card/data/controller/preview_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

//Todo - consume the right api and remove dummy data and model from this page, major refactring needed

class PreviewCardScreenMobile extends StatefulHookConsumerWidget {
  const PreviewCardScreenMobile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreviewCardScreenMobileState();
}

class _PreviewCardScreenMobileState
    extends ConsumerState<PreviewCardScreenMobile> {
  @override
  void initState() {
    super.initState();
    ref.read(previewProvider).loadUserDetails();
  }

  Future<String> getSavedUsername(String socialMediaId) async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString(socialMediaId) ?? '';
    return savedUsername;
  }

  @override
  Widget build(BuildContext context) {
    final profileController = ref.read(profileProvider);
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

    final String? firstName =
        StorageUtil.getString(key: OnboardingString.firstName);
    final String? lastName =
        StorageUtil.getString(key: OnboardingString.lastName);
    final String? otherName =
        StorageUtil.getString(key: OnboardingString.otherName);
    final String? workEmail =
        StorageUtil.getString(key: OnboardingString.workEmail);
    final String? phoneNumber =
        StorageUtil.getString(key: OnboardingString.phoneNumber);
    final String? jobTitle =
        StorageUtil.getString(key: OnboardingString.jobTitle);
    final String? companyName =
        StorageUtil.getString(key: OnboardingString.companyName);
    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.grayScale50,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.asset(
                    ImageAssets.cardBanner,
                    width: MediaQuery.of(context).size.width,
                    height: 230,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 25,
                    top: 120,
                    child: userProfileImage(
                      image: StorageUtil.getString(key: 'profileImage'),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: AppColors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$firstName $lastName',
                            style: WonderCardTypography.boldTextH5(
                              fontSize: SpacingConstants.size23,
                              color: AppColors.grayScale,
                            ),
                          ),
                          Text(
                            '$jobTitle@$companyName',
                            style: WonderCardTypography.boldTextTitle2(
                              fontSize: SpacingConstants.size16,
                              color: AppColors.grayScale600,
                            ),
                          ),
                          const Divider(),
                          ReusableUserDataCard(
                            text: workEmail,
                            widget: const HeroIcon(
                              HeroIcons.envelope,
                              color: AppColors.primaryShade,
                              size: SpacingConstants.size15,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ReusableUserDataCard(
                            text: phoneNumber,
                            widget: const HeroIcon(
                              HeroIcons.phone,
                              color: AppColors.primaryShade,
                              size: SpacingConstants.size15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(child: const CustomContainer()),
                    const SizedBox(
                      height: 20,
                    ),
                    ContinueWidget(
                      buttonText: editCard,
                      textColor: AppColors.defaultWhite,
                      bgColor: AppColors.primaryShade,
                      onTap: () {
                        context.go(RouteString.fifthScreen);
                      },
                      onPress: () {
                        context.go(RouteString.signup);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableUserDataCard extends StatelessWidget {
  const ReusableUserDataCard({
    super.key,
    required this.text,
    required this.widget,
  });

  final String? text;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(SpacingConstants.size10),
          decoration: BoxDecoration(
              color: AppColors.defaultWhite,
              borderRadius: BorderRadius.circular(100)),
          width: SpacingConstants.size45,
          height: SpacingConstants.size45,
          child: widget,
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text ?? emptyString,
              style: WonderCardTypography.boldTextH5(
                fontSize: SpacingConstants.size16,
                color: AppColors.grayScale,
              ),
            ),
            Text(
              businessText,
              style: WonderCardTypography.boldTextTitle2(
                fontSize: SpacingConstants.size13,
                color: AppColors.grayScale400,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345,
      height: 216,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: SpacingConstants.size15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    socialLinkText,
                    style: WonderCardTypography.boldTextTitle2(
                      fontSize: SpacingConstants.size16,
                      color: AppColors.grayScale,
                    ),
                  ),
                  Text(
                    viewAllText,
                    style: WonderCardTypography.boldTextTitle2(
                      fontSize: SpacingConstants.size16,
                      color: AppColors.grayScale300,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: SpacingConstants.size15,
              ),
              const MyGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialMediaWidget extends HookConsumerWidget {
  const SocialMediaWidget({
    super.key,
    required this.titleText,
    required this.image,
  });

  final String titleText;
  final String image;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: SpacingConstants.size100,
      height: SpacingConstants.size120,
      child: Column(
        children: [
          BehanceAvatar(
            image: image,
          ),
          Text(
            titleText,
            style: WonderCardTypography.regularTextTitle2(
              color: AppColors.grayScale500,
              fontSize: SpacingConstants.size16,
            ),
          )
        ],
      ),
    );
  }
}

class MyGridView extends HookConsumerWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socialController = ref.watch(socialProvider);

    useEffect(() {
      Future.delayed(Duration.zero, () async {
        try {
          await ref.read(socialProvider).getSocialMedia(context);
        } catch (error) {}
      });
      return null;
    }, []);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: socialController.socialMedias.length,
          itemBuilder: (context, index) {
            final socialMedia = socialController.socialMedias[index];

            return FutureBuilder<Map<String, String?>>(
              future: _getSavedData(socialMedia.name),
              builder: (context, snapshot) {
                final data = snapshot.data ?? {};
                final savedUsername = data['username'] ?? 'Enter your username';
                final savedBaseUrl = data['baseUrl'] ?? '';
                final savedName = data['controllerName'] ?? 'facebook';

                // Check if `socialMedia.name` contains the `savedBaseUrl`
                final titleToDisplay = socialMedia.name.contains(savedBaseUrl)
                    ? socialMedia.name
                    : savedUsername;

                return SocialMediaWidget(
                  titleText: savedName,
                  image: savedBaseUrl,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<Map<String, String?>> _getSavedData(String socialMediaId) async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString('${socialMediaId}_username'),
      'baseUrl': prefs.getString('${socialMediaId}_baseUrl'),
      'controllerName': prefs.getString('${socialMediaId}_controllerName'),
    };
  }
}
