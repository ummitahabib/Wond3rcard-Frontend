import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/views/authentication/log_out/views/pages/desktop/logout_desktop.dart';
import 'package:wond3rcard/src/authentication/views/authentication/log_out/views/pages/mobile/logout_mobile.dart';
import 'package:wond3rcard/src/authentication/views/authentication/log_out/views/pages/tablet/logout_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';

class LogOutMain extends HookConsumerWidget {
  const LogOutMain({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
        desktop: LogoutDesktop(),
        tablet: LogoutTablet(),
        mobile: LogoutMobile());
  }
}
