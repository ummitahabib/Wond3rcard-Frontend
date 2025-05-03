import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/social_media/data/model/social_media.dart';
import 'package:wond3rcard/src/admin/social_media/data/repository/social_media_repository.dart';
import 'package:wond3rcard/src/utils/alert.dart';

final socialProvider = ChangeNotifierProvider<SocialMediaNotifier>((ref) {
  return SocialMediaNotifier(ref);
});

class SocialMediaNotifier extends ChangeNotifier {
  final Ref ref;

  SocialMediaNotifier(this.ref);

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool state) {
    _loading = state;
    notifyListeners();
  }

  SocialMedia? _socialMediaModel;

  SocialMedia? get socialMediaModel => _socialMediaModel;

  set socialMediaModel(SocialMedia? socialMedia) {
    _socialMediaModel = socialMedia;
    notifyListeners();
  }

  List<SocialMedia> _socialMedias = [];

  List<SocialMedia> get socialMedias => _socialMedias;

  set socialMedias(List<SocialMedia> socialMediaList) {
    _socialMedias = socialMediaList;
    notifyListeners();
  }

  final Map<int, bool> expandedItems = {};

  final TextEditingController nameController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  void clearControllers() {
    nameController.clear();
    linkController.clear();
    imageUrlController.clear();
  }

  Future<bool> createSocialMedia(BuildContext context) async {
    final String name = nameController.text;
    final String link = linkController.text;
    final String imageUrl = imageUrlController.text;

    if (name.isEmpty || link.isEmpty || imageUrl.isEmpty) {
      alert.showErrorToast(message: "All fields are required.");
      return false;
    }

    final SocialMedia socialMedia = SocialMedia(
      name: name,
      link: link,
      imageUrl: imageUrl,
    );

    try {
      loading = true;

      final response = await ref
          .read(socialMediaRepositoryProvider)
          .createSocialMedia(socialMedia);

      loading = false;

      if (response.hasError()) {
        alert.showErrorToast(
            message: response.error?.message ??
                "Failed to create social media entry.");
        return false;
      } else {
        alert.showSuccessToast(
            message: "Social media entry created successfully!");
        clearControllers();
        return true;
      }
    } catch (e) {
      loading = false;
      alert.showErrorToast(message: "An unexpected error occurred.");
      return false;
    }
  }

  Future<void> deleteSocialMedia(BuildContext context) async {
    const String socialMediaId = '';
    try {
      loading = true;
      final response = await ref
          .watch(socialMediaRepositoryProvider)
          .deleteSocialMedia(socialMediaId);

      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
        loading = false;
      } else {
        alert.showSuccessToast(message: 'social media deleted successfull');
        loading = false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSocialMedia(BuildContext context) async {
    try {
      loading = true;
      final response =
          await ref.watch(socialMediaRepositoryProvider).getSocialMedias();

      if (response.hasError()) {
        alert.showErrorToast(message: response.error!.message);
      } else {
        final socialMediaResponse = response.response as SocialMediaResponse;
        socialMedias = socialMediaResponse.payload;
      }
    } catch (e) {
      alert.showErrorToast(message: 'An error occurred');
      print(e);
    } finally {
      loading = false;
    }
  }
}
