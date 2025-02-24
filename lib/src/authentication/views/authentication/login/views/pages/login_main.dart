import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/views/authentication/login/views/pages/desktop/login_desktop.dart';
import 'package:wond3rcard/src/authentication/views/authentication/login/views/pages/mobile/login_mobile.dart';
import 'package:wond3rcard/src/authentication/views/authentication/login/views/pages/tablet/login_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class LogInMain extends HookConsumerWidget {
  const LogInMain({
    super.key,
  });

  static const routeName = RouteString.logIn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: LoginDesktop(),
      tablet: LoginTablet(),
      mobile: LoginMobile(),
    );
  }
}
