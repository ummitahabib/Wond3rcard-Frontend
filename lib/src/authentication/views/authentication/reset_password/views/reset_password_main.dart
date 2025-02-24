import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/views/authentication/reset_password/views/pages/desktop/reset_password_desktop.dart';
import 'package:wond3rcard/src/authentication/views/authentication/reset_password/views/pages/mobile/reset_password_mobile.dart';
import 'package:wond3rcard/src/authentication/views/authentication/reset_password/views/pages/tablet/reset_password_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class ResetPasswordMain extends HookConsumerWidget {
  const ResetPasswordMain({super.key});

  static const routeName = RouteString.resetPassword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: ResetPassowrdDesktop(),
      tablet: ResetPassowrdTablet(),
      mobile: ResetPassowrdMobile(),
    );
  }
}
