import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/views/authentication/forgot_password_otp_verification/views/pages/desktop/forgot_password_otp_verification_desktop.dart';
import 'package:wond3rcard/src/authentication/views/authentication/forgot_password_otp_verification/views/pages/mobile/forgot_password_otp_verification_mobile.dart';
import 'package:wond3rcard/src/authentication/views/authentication/forgot_password_otp_verification/views/pages/tablet/forgot_password_otp_verification_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class ForgotPasswordOtpVerification extends HookConsumerWidget {
  const ForgotPasswordOtpVerification({super.key});

  static const routeName = RouteString.forgetPasswordOtpVerification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: ForgotPasswordOtpVerificationDesktop(),
      tablet: ForgotPasswordOtpVerificationTablet(),
      mobile: ForgotPasswordOtpVerificationMobile(),
    );
  }
}
