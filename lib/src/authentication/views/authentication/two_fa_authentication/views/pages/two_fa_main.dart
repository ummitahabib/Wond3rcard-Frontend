import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/views/authentication/two_fa_authentication/views/pages/desktop/two_fa_desktop.dart';
import 'package:wond3rcard/src/authentication/views/authentication/two_fa_authentication/views/pages/mobile/two_fa_mobile.dart';
import 'package:wond3rcard/src/authentication/views/authentication/two_fa_authentication/views/pages/tablet/two_fa_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class TwoFaAuthMain extends HookConsumerWidget {
  const TwoFaAuthMain({
    super.key,
  });

  static const routeName = RouteString.twoFAuth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: TwoFactorAuthDesktop(),
      tablet: TwoFactorAuthTablet(),
      mobile: TwoFactorAuthMobile(),
    );
  }
}
