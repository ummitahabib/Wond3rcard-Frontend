import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/privacy_security/views/pages/desktop/privacy_security_desktop.dart';
import 'package:wond3rcard/src/privacy_security/views/pages/mobile/privacy_security_mobile.dart';
import 'package:wond3rcard/src/privacy_security/views/pages/tablet/privacy_security_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class PrivacySecurityMainScreen extends HookConsumerWidget {
  const PrivacySecurityMainScreen({super.key});

  static const routeName = RouteString.privacySecurity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: PrivacySecurityScreenDesktop(),
      mobile: PrivacySecurityScreenMobile(),
      tablet: PrivacySecurityScreenTablet(),
    );
  }
}
