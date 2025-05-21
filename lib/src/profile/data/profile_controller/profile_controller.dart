import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/profile/data/profile_model/profile.dart';
import 'package:wond3rcard/src/profile/data/profile_repository/profile_repository.dart';
import 'package:wond3rcard/src/utils/alert.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final profileProvider = ChangeNotifierProvider<ProfileNotifier>((ref) {
  return ProfileNotifier(ref);
});

class ProfileNotifier extends ChangeNotifier {
  final Ref ref;

  ProfileNotifier(this.ref);

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool state) {
    _loading = state;
    notifyListeners();
  }

  UserProfileResponse? profileData;

  Future<UserProfileResponse?> getProfile(BuildContext context) async {
    try {
      loading = true;
      final response = await ref.read(profileRepoProvider).getProfile();
      loading = false;
      if (response.hasError()) {
       // alert.showErrorToast(message: response.error?.message ?? emptyString);

        print('this is the get profile error ${response.error?.message}');
      } else {
        final profile = response.response as UserProfileResponse;
        profileData = profile;
        StorageUtil.putString(
            key: SessionString.userId, value: profileData!.payload.profile.id);

        StorageUtil.putString(
            key: SessionString.profileUrl,
            value: profileData!.payload.profile.profileUrl);
        log(profileData!.payload.profile.id);
        return profile;
      }
    } catch (e) {
      // print('this is the catch error $e');
      // alert.showErrorToast(
      //   message: 'unableToCompleteProcess',
      // );
      loading = false;
      return null;
    }
    return null;
  }
}
