import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_wrap/smart_wrap.dart';
import 'package:wond3rcard/src/admin/social_media/data/controller/social_media_controller.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/card.dart';
import 'package:wond3rcard/src/cards/views/widgets/business_catelog_widget.dart';
import 'package:wond3rcard/src/cards/views/widgets/home_address_widget.dart';
import 'package:wond3rcard/src/cards/views/widgets/testimonies_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/preview_card/data/controller/preview_controller.dart';
import 'package:wond3rcard/src/onboarding_preview_card/views/pages/mobile/onboarding_preview_card_mobile.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_model/profile.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/test/get_card/getcard.dart';

class CardDetails extends StatefulHookConsumerWidget {
  const CardDetails({super.key, required this.index});

  final int index;

  static const String routeName = RouteString.cardDetails;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardDetailsState();
}

class _CardDetailsState extends ConsumerState<CardDetails> {
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

  void _navigateToEditCard(BuildContext context, String? cardId) {
    if (cardId != null && cardId.isNotEmpty) {
      context.go('${RouteString.createNewCard}?cardId=$cardId');
    } else {
      context.go(RouteString.createNewCard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileController = ref.read(profileProvider);
    final cardController = ref.watch(cardProvider);
    final profile = profileController.profileData?.payload.profile;
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          if (profileController.profileData == null) {
            Future.delayed(Duration.zero, () async {
              await profileController.getProfile(context);
              await ref.read(cardProvider).getAUsersCard(
                    context,
                    cardController.getCardsResponse?.payload
                            ?.cards?[widget.index].id ??
                        '',
                  );
            });
          }
        });
        return null;
      },
      [],
    );

    // Get the card id for passing to the create card screen
    final cardId =
        cardController.getCardsResponse?.payload?.cards?[widget.index].id;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: HeroIcon(
            HeroIcons.chevronLeft,
            color: Colors.black,
          ),
          onPressed: () {
            isDesktop(context)
                ? context.go(RouteString.cardMain)
                : context.go(RouteString.mainDashboard);
          },
        ),
      ),
      body: SingleChildScrollView(
          child: isDesktop(context)
              ? Center(
                  child: Container(
                    color: AppColors.grayScale50,
                    width: isDesktop(context)
                        ? MediaQuery.of(context).size.width / 4
                        : MediaQuery.of(context).size.width,
                    child: _cardDetails(context, profileController,
                        cardController, profile, cardId),
                  ),
                )
              : Container(
                  color: AppColors.grayScale50,
                  width: MediaQuery.of(context).size.width,
                  child: _cardDetails(context, profileController,
                      cardController, profile, cardId),
                )),
    );
  }

  Column _cardDetails(
    BuildContext context,
    ProfileNotifier profileController,
    CardNotifier cardController,
    Profile? profile,
    String? cardId,
  ) {
    return Column(
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
              child: Container(
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
                    borderRadius:
                        BorderRadius.circular(SpacingConstants.size100),
                    border:
                        Border.all(width: 4, color: AppColors.defaultWhite)),
                child: Container()
                //temp 
                // CircleAvatar(
                //   radius: 40,
                //   backgroundColor: AppColors.defaultWhite,
                //   backgroundImage: NetworkImage(
                //     cardController.getCardsResponse?.payload
                //             ?.cards?[widget.index].cardPictureUrl ??
                //         emptyString,
                //   ),
                // ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SmartWrap(
            type: WrapType.column,
            runSpacing: 10.0,
            spacing: 10.0,
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
                      cardController.getCardsResponse?.payload
                              ?.cards?[widget.index].cardName ??
                          emptyString,
                      style: WonderCardTypography.boldTextH5(
                        fontSize: SpacingConstants.size23,
                        color: AppColors.grayScale,
                      ),
                    ),
                    Text(
                      '${profile?.designation}@${profile?.companyName}',
                      style: WonderCardTypography.boldTextTitle2(
                        fontSize: SpacingConstants.size16,
                        color: AppColors.grayScale600,
                      ),
                    ),
                    const Divider(),
                    ReusableUserDataCard(
                      text: cardController.getCardsResponse?.payload
                          ?.cards?[widget.index].contactInfo?.email,
                      widget: const HeroIcon(
                        HeroIcons.envelope,
                        color: AppColors.primaryShade,
                        size: SpacingConstants.size15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ReusableUserDataCard(
                      text: cardController.getCardsResponse?.payload
                          ?.cards?[widget.index].contactInfo?.phone,
                      widget: const HeroIcon(
                        HeroIcons.phone,
                        color: AppColors.primaryShade,
                        size: SpacingConstants.size15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.go(RouteString.connections);
                    },
                    child: Container(
                      width: 162,
                      height: 60,
                      decoration: BoxDecoration(
                          color: AppColors.primaryShade,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Connect',
                              style: WonderCardTypography.boldTextTitleBold(
                                  fontSize: 18, color: AppColors.defaultWhite)),
                          SizedBox(width: 5),
                          HeroIcon(
                            HeroIcons.link,
                            color: AppColors.defaultWhite,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go(RouteString.contacts);
                    },
                    child: Container(
                        width: 162,
                        height: 60,
                        decoration: BoxDecoration(
                            color: AppColors.primaryShade,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text('Exchange Contact',
                              style: WonderCardTypography.boldTextTitleBold(
                                  fontSize: 18, color: AppColors.defaultWhite)),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  height: 341,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.defaultWhite,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Social media connect',
                              style: WonderCardTypography.boldTextTitleBold(
                                fontSize: 18,
                                color: AppColors.grayScale600,
                              ),
                            ),
                          ),
                        ),

                         //temp 
                        // SocialMediaSection(
                        //     socialLinks: cardController
                        //             .getCardsResponse
                        //             ?.payload
                        //             ?.cards?[widget.index]
                        //             .socialMediaLinks ??
                        //         []
                        //         ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
               //temp 
              // BusinessAddressSection(
              //   businessName: cardController.getCardsResponse?.payload
              //       ?.cards?[widget.index].designation,
              //   address: cardController.getCardsResponse?.payload
              //       ?.cards?[widget.index].contactInfo?.address,
              //   city: cardController.getCardsResponse?.payload
              //       ?.cards?[widget.index].contactInfo?.website,
              //   state: "Lagos State",
              //   country: cardController.getCardsResponse?.payload
              //       ?.cards?[widget.index].contactInfo?.email,
              //   postalCode: cardController.getCardsResponse?.payload
              //       ?.cards?[widget.index].contactInfo?.phone,
              // ),
              const SizedBox(
                height: 8,
              ),
              BusinessCatalogWidget(),
              const SizedBox(
                height: 8,
              ),
              TestimoniesWidget(),
              ContinueWidget(
                showLoader: cardController.loading,
                buttonText: editCard,
                textColor: AppColors.defaultWhite,
                bgColor: AppColors.primaryShade,
                onTap: () => _navigateToEditCard(context, cardId),
                onPress: () => _navigateToEditCard(context, cardId),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SocialsGridView extends HookConsumerWidget {
  const SocialsGridView({super.key});

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
        height: 207,
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

                return SocialItemMediaWidget(
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

class SocialItemMediaWidget extends HookConsumerWidget {
  const SocialItemMediaWidget({
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              image,
              width: 69.64,
              height: 69.64,
            ),
          ),
          Text(titleText, style: WonderCardTypography.boldTextTitleBold())
        ],
      ),
    );
  }
}

class SocialMediaSection extends StatelessWidget {
  final List<SocialMediaLink> socialLinks;

  const SocialMediaSection({super.key, required this.socialLinks});

  void _openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (socialLinks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: ListView.separated(
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: socialLinks.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final link = socialLinks[index];
              final media = link.media;

              if (!(link.active ?? false) ||
                  media == null ||
                  media.link == null) {
                return const SizedBox.shrink();
              }

              return ListTile(
                onTap: () => _openLink(media.link!),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: media.iconUrl != null
                      ? NetworkImage(media.iconUrl!)
                      : null,
                  child: media.iconUrl == null ? const Icon(Icons.link) : null,
                ),
                title: Text(media.name ?? 'Unknown'),
                subtitle: Text('@${link.username ?? ''}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              );
            },
          ),
        ),
      ],
    );
  }
}
