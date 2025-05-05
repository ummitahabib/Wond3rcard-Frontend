import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/views/authentication/login/views/widgets/log_in_textfield.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class LoginMobile extends HookConsumerWidget {
  const LoginMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(ImageAssets.splashScreenOnboardFrame2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: size20,
                  right: size20,
                  top: size30,
                ),
                child: _loginWelcomeText(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingConstants.size20,
                ),
                child: _logInWithEmailAndPassword(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: SpacingConstants.size10,
                vertical: SpacingConstants.size15),
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SpacingConstants.size10,
                      vertical: SpacingConstants.size15),
                  child: _logInBgImage(context),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SpacingConstants.size10,
                      vertical: SpacingConstants.size15),
                  child: LoginTextField(),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Image _logInBgImage(BuildContext context) {
    return Image.asset(
      ImageAssets.lockFrame,
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
      height: SpacingConstants.size394,
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
