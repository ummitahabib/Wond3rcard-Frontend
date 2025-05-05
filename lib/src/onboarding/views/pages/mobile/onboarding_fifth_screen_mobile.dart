import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/detail_container.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/title_section.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wond3rcard/src/admin/social_media/data/controller/social_media_controller.dart';
import 'package:wond3rcard/src/utils/decoration_box.dart';

class OnboardingFifthScreenMobile extends StatefulHookConsumerWidget {
  const OnboardingFifthScreenMobile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingFifthScreenMobileState();
}

class _OnboardingFifthScreenMobileState
    extends ConsumerState<OnboardingFifthScreenMobile> {
  @override
  Widget build(BuildContext context) {
    final socialController = ref.watch(socialProvider);

    useEffect(
      () {
        Future.delayed(Duration.zero, () async {
          try {
            await ref.read(socialProvider).getSocialMedia(context);
          } catch (error) {}
        });
        return null;
      },
      [],
    );

    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.grayScale50,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Image.asset(ImageAssets.splashScreenOnboardFrame2),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: SpacingConstants.size30,
                  horizontal: SpacingConstants.size10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleSection(),
                    const SizedBox(
                      height: SpacingConstants.size50,
                    ),
                    socialController.loading
                        ? const Center(child: CircularProgressIndicator())
                        : socialController.socialMedias.isEmpty
                            ? const Center(
                                child: Text('No social media links found.'))
                            : Container(),
                    const Spacer(),
                    ContinueWidget(
                      showLoader: socialController.loading,
                      onTap: () {
                        context.go(RouteString.fourthScreen);
                      },
                      buttonText: previewCardText,
                      textColor: AppColors.defaultWhite,
                      onPress: () {
                        context.go(RouteString.previewCard);
                      },
                      bgColor: AppColors.primaryShade,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialMediaList extends StatefulHookConsumerWidget {
  final ValueNotifier<List<SocialMediaLink>> selectedLinks;

  const SocialMediaList({super.key, required this.selectedLinks});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SocialMediaListState();
}

class _SocialMediaListState extends ConsumerState<SocialMediaList> {
  final Map<String, bool> selected = {};
  final Map<String, TextEditingController> usernameControllers = {};

  @override
  void initState() {
    super.initState();
    for (var media in staticSocialMediaList) {
      selected[media.name] = false;
      usernameControllers[media.name] = TextEditingController();
    }
  }

  void updateSelectedLinks() {
    widget.selectedLinks.value = staticSocialMediaList
        .where((media) => selected[media.name] == true)
        .map(
          (media) => SocialMediaLink(
            media: media,
            username: usernameControllers[media.name]?.text ?? '',
            active: true,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: SpacingConstants.size346,
        decoration: DecorationBox.detailContainerDecorationBox(),
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: staticSocialMediaList.length,
          itemBuilder: (context, index) {
            final media = staticSocialMediaList[index];
            final isSelected = selected[media.name] ?? false;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Image.asset(media.iconPath, width: 30, height: 30),
                  title: Text(media.name),
                  subtitle: Text(media.type),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (val) {
                      setState(() {
                        selected[media.name] = val ?? false;
                        updateSelectedLinks();
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      selected[media.name] = !(selected[media.name] ?? false);
                      updateSelectedLinks();
                    });
                  },
                ),
                if (isSelected)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: usernameControllers[media.name],
                      decoration: InputDecoration(
                        labelText: 'Enter ${media.name} username',
                      ),
                      onChanged: (_) => updateSelectedLinks(),
                    ),
                  ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}

List<SocialMedia> staticSocialMediaList = [
  SocialMedia(
    name: 'Behance',
    type: 'Education/Work',
    iconPath: 'images/behance.png',
    baseUrl: 'https://www.behance.net/',
  ),
  SocialMedia(
    name: 'LinkedIn',
    type: 'Professional Network',
    iconPath: 'images/linkedIn.png',
    baseUrl: 'https://www.linkedin.com/in/',
  ),
  SocialMedia(
    name: 'Instagram',
    type: 'Photo/Video Sharing',
    iconPath: 'images/instagram.png',
    baseUrl: 'https://www.instagram.com/',
  ),
  SocialMedia(
    name: 'Twitter',
    type: 'Microblogging',
    iconPath: 'images/x-icon.png',
    baseUrl: 'https://twitter.com/',
  ),
];

class SocialMedia {
  final String name;
  final String type;
  final String iconPath;
  final String baseUrl;

  SocialMedia({
    required this.name,
    required this.type,
    required this.iconPath,
    required this.baseUrl,
  });
}

class SocialMediaLink {
  final SocialMedia media;
  final String username;
  final bool active;

  SocialMediaLink({
    required this.media,
    required this.username,
    required this.active,
  });

  Map<String, dynamic> toJson() => {
        'media': {
          'iconUrl': media.iconPath,
          'name': media.name,
          'type': media.type,
          'link': '${media.baseUrl}${username.trim()}', 
        },
        'username': username,
        'active': active,
      };
}
