import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/desktop_onboarding_constant_widget.dart';
import 'package:wond3rcard/src/authentication/views/authentication/login/views/widgets/log_in_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class LoginDesktop extends HookConsumerWidget {
  const LoginDesktop({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 2, child: getStartedStack(context)),
          Spacer(),
          Expanded(flex: 3, child: LoginData()),
        ],
      ),
    );
  }
}

class LoginData extends HookConsumerWidget {
  const LoginData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingConstants.size20,
              vertical: SpacingConstants.size20,
            ),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _loginWelcomeText(),
                  _logInWithEmailAndPassword(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: SpacingConstants.size10,
                vertical: SpacingConstants.size15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: size25,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: LoginTextField()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _logInWithEmailAndPassword() {
    return Text(
      logInWithEmailAndPassword,
      style: WonderCardTypography.regularTextTitle2(
          color: AppColors.grayScale700, fontSize: SpacingConstants.size16),
    );
  }

  Text _loginWelcomeText() {
    return Text(
      welcomeBackText,
      style: WonderCardTypography.boldTextH4(
        color: AppColors.grayScale,
        fontSize: SpacingConstants.size28,
      ),
    );
  }
}
