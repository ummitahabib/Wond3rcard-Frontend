import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/decoration_box.dart';

import 'package:shared_preferences/shared_preferences.dart';

class OnboardingFifthScreenMobile extends StatefulHookConsumerWidget {
  const OnboardingFifthScreenMobile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingFifthScreenMobileState();
}

class _OnboardingFifthScreenMobileState
    extends ConsumerState<OnboardingFifthScreenMobile> {
  late final ValueNotifier<List<SocialMediaLink>> selectedLinks;

  @override
  void initState() {
    super.initState();
    selectedLinks = ValueNotifier<List<SocialMediaLink>>([]);
  }

  @override
  void dispose() {
    selectedLinks.dispose();
    super.dispose();
  }

  Future<void> _saveSocialMediaLinks(List<SocialMediaLink> links) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> socialMediaJsonList = links.map((link) {
      // Only store image, name, and url
      final url = '${link.media.baseUrl}${link.username.trim()}';
      return {
        'iconPath': link.media.iconPath,
        'name': link.media.name,
        'url': url,
      }.toString();
    }).toList();
    await prefs.setStringList('social_media_links', socialMediaJsonList);
  }

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      'Connect your Socials',
                      style: WonderCardTypography.boldTextH4(
                        fontSize: SpacingConstants.size28,
                        color: AppColors.grayScale,
                      ),
                    ),
                    const SizedBox(height: SpacingConstants.size30),
                    SocialMediaList(selectedLinks: selectedLinks),
                    const Spacer(),
                    ContinueWidget(
                      showLoader: false,
                      onTap: () async {
                        await _saveSocialMediaLinks(selectedLinks.value);
                        context.go(RouteString.previewCard);
                      },
                      buttonText: previewCardText,
                      textColor: AppColors.defaultWhite,
                      onPress: () async {
                        await _saveSocialMediaLinks(selectedLinks.value);
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
