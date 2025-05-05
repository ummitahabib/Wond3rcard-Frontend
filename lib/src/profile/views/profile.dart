import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/profile/views/pages/desktop/profile_desktop.dart';
import 'package:wond3rcard/src/profile/views/pages/mobile/profile_mobile.dart';
import 'package:wond3rcard/src/profile/views/pages/tablet/profile_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class ProfileMainScreen extends HookConsumerWidget {
  const ProfileMainScreen({super.key});

  static const routeName = RouteString.profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: ProfileScreenDesktop(),
      mobile: ProfileScreenMobile(),
      tablet: ProfileScreenTablet(),
    );
  }
}
