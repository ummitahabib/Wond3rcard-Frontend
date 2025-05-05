import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/profile/views/pages/desktop/edit_profile_desktop.dart';
import 'package:wond3rcard/src/profile/views/pages/mobile/edit_profile_mobile.dart';
import 'package:wond3rcard/src/profile/views/pages/tablet/edit_profile.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class EditProfileMainScreen extends HookConsumerWidget {
  const EditProfileMainScreen({super.key});

  static const routeName = RouteString.editProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: EditProfileDesktop(),
      mobile: EditProfileMobile(),
      tablet: EditProfileTablet(),
    );
  }
}
