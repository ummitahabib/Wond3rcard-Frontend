import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/views/authentication/otp_verification/views/pages/desktop/otp_verification_desktop.dart';
import 'package:wond3rcard/src/authentication/views/authentication/otp_verification/views/pages/mobile/otp_verification_mobile.dart';
import 'package:wond3rcard/src/authentication/views/authentication/otp_verification/views/pages/tablet/otp_verification_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';

class OtpVerification extends HookConsumerWidget {
  const OtpVerification({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: OtpVerificationDesktop(),
      tablet: OtpVerificationTablet(),
      mobile: OtpVerificationMobile(),
    );
  }
}
