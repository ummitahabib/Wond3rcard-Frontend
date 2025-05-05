import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_screen_title_widget.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class ResetPassowrdMobile extends HookConsumerWidget {
  const ResetPassowrdMobile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: Container(
        color: AppColors.grayScale50,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _resetPasswordStack(authController, context),
      ),
    );
  }

  Stack _resetPasswordStack(AuthNotifier authController, BuildContext context) {
    return Stack(
      children: [
        Image.asset(ImageAssets.splashScreenOnboardFrame2),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: SpacingConstants.size30,
              horizontal: SpacingConstants.size10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: SpacingConstants.size40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const OnboardingScreenTitleText(text: resetPasswordText),
                      Text(
                        resetPasswordDescr,
                        style: WonderCardTypography.regularTextTitle2(
                          fontSize: SpacingConstants.size16,
                          color: AppColors.grayScale700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: SpacingConstants.size100,
              ),
              CustomTextField(
                fillColor: AppColors.defaultWhite,
                textColor: AppColors.grayScale600,
                type: TextFieldType.Email,
                text: enterPersonalEmail,
                inputType: TextInputType.emailAddress,
                isRequired: true,
                hintText: exampleEmailText,
                textEditingController: authController.emailController,
              ),
              const Spacer(),
              ContinueWidget(
                showLoader: authController.loading,
                onTap: () {
                  context.go(RouteString.logIn);
                },
                bgColor: AppColors.primaryShade,
                buttonText: continueText,
                textColor: AppColors.defaultWhite,
                onPress: () async {
                  authController.forgotPassword();
                  context.go(RouteString.forgetPasswordOtpVerification);
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    SpacingConstants.sizes0point1,
              )
            ],
          ),
        )
      ],
    );
  }
}

Column onboardingTitle(String text1, String text2) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      OnboardingScreenTitleText(
        text: text1,
      ),
      OnboardingScreenTitleText(
        text: text2,
      ),
    ],
  );
}
