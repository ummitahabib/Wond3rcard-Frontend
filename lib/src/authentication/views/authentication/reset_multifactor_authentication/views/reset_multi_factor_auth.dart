import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/views/authentication/reset_multifactor_authentication/views/pages/desktop/reset_multi_factor_auth_desktop.dart';
import 'package:wond3rcard/src/authentication/views/authentication/reset_multifactor_authentication/views/pages/mobile/reset_multi_factor_auth_mobile.dart';
import 'package:wond3rcard/src/authentication/views/authentication/reset_multifactor_authentication/views/pages/tablet/reset_multifactor_auth_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';

class ResetMultiFactorAuthentication extends HookConsumerWidget {
  const ResetMultiFactorAuthentication({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: ResetMultiFactorAuthenticationDesktop(),
      tablet: ResetMultiFactorAuthenticationTablet(),
      mobile: ResetMultiFactorAuthenticationMobile(),
    );
  }
}
