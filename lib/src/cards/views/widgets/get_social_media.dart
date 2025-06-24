import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/social_media/data/controller/social_media_controller.dart';
import 'package:wond3rcard/src/admin/social_media/data/model/social_media.dart';
import 'package:wond3rcard/src/utils/decoration_box.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';

class GetSocialMedia extends StatefulHookConsumerWidget {
  final ValueNotifier<List<SocialMedia>> selectedLinks;

  const GetSocialMedia({super.key, required this.selectedLinks});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetSocialMediaState();
}

class _GetSocialMediaState extends ConsumerState<GetSocialMedia> {
  final Map<String, bool> selected = {};
  final Map<String, TextEditingController> usernameControllers = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(socialProvider).getSocialMedia(context);
    });
  }

  void updateSelectedLinks(List<SocialMedia> socialMedias) {
    widget.selectedLinks.value = socialMedias
        .where((media) => selected[media.name] == true)
        .map(
          (media) => SocialMedia(
            imageUrl: usernameControllers[media.name]?.text ?? '',
            link: usernameControllers[media.link]?.text ?? '',
            name: usernameControllers[media.name]?.text ?? '',
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(socialProvider);
    final socialMedias = notifier.socialMedias;
    final isLoading = notifier.loading;

    // Ensure controllers and selection are initialized
    for (var media in socialMedias) {
      selected.putIfAbsent(media.name, () => false);
      usernameControllers.putIfAbsent(
          media.name, () => TextEditingController());
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: SpacingConstants.size346,
        decoration: DecorationBox.detailContainerDecorationBox(),
        padding: const EdgeInsets.all(8),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : socialMedias.isEmpty
                ? const Center(child: Text('No social media links found.'))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: socialMedias.length,
                    itemBuilder: (context, index) {
                      final media = socialMedias[index];
                      final isSelected = selected[media.name] ?? false;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Image.network(
                              media.imageUrl,
                              width: 30,
                              height: 30,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                            title: Text(media.name),
                            subtitle: Text(media.mediaType ?? ''),
                            trailing: Checkbox(
                              value: isSelected,
                              onChanged: (val) {
                                setState(() {
                                  selected[media.name] = val ?? false;
                                  updateSelectedLinks(socialMedias);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                selected[media.name] =
                                    !(selected[media.name] ?? false);
                                updateSelectedLinks(socialMedias);
                              });
                            },
                          ),
                          if (isSelected)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                controller: usernameControllers[media.name],
                                decoration: InputDecoration(
                                  labelText: 'Enter ${media.name} username',
                                ),
                                onChanged: (_) =>
                                    updateSelectedLinks(socialMedias),
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
