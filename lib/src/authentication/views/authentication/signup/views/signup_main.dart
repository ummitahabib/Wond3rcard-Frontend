import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/views/authentication/signup/views/pages/desktop/signup_desktop.dart';
import 'package:wond3rcard/src/authentication/views/authentication/signup/views/pages/mobile/signup_mobile.dart';
import 'package:wond3rcard/src/authentication/views/authentication/signup/views/pages/tablet/signup_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class SignUpMain extends HookConsumerWidget {
  const SignUpMain({
    super.key,
  });

  static const routeName = RouteString.signup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: SignUpDesktop(),
      tablet: SignUpTablet(),
      mobile: SignUpMobile(),
    );
  }
}
