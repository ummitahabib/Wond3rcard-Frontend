import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/desktop_onboarding_constant_widget.dart';

import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_screen_title_widget.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_text_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class ResetPassowrdDesktop extends HookConsumerWidget {
  const ResetPassowrdDesktop({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.defaultWhite,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(flex: 2, child: getStartedStack(context)),
          Spacer(),
          Expanded(flex: 3, child: ResetPasswordData()),
        ],
      ),
    );
  }
}

class ResetPasswordData extends HookConsumerWidget {
  const ResetPasswordData({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authProvider);
    return Container(
      padding: EdgeInsets.all(50),
      margin: EdgeInsets.all(50),
      height: MediaQuery.of(context).size.height,
      child: _resetPasswordStack(authController, context),
    );
  }

  Widget _resetPasswordStack(
      AuthNotifier authController, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const OnboardingScreenTitleText(text: resetPasswordText),
        Text(
          resetPasswordDescr,
          style: WonderCardTypography.regularTextTitle2(
            fontSize: SpacingConstants.size16,
            color: AppColors.grayScale700,
          ),
        ),
        const SizedBox(
          height: SpacingConstants.size100,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: CustomTextField(
            fillColor: AppColors.defaultWhite,
            textColor: AppColors.grayScale600,
            type: TextFieldType.Email,
            text: enterPersonalEmail,
            inputType: TextInputType.emailAddress,
            isRequired: true,
            hintText: exampleEmailText,
            textEditingController: authController.emailController,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              WonderCardTextButton(
                onPressed: () {
                  context.go(RouteString.signup);
                },
                text: signUpText,
                color: AppColors.primaryShade,
              ),
              Spacer(),
              Container(),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: ContinueWidget(
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
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height *
              SpacingConstants.sizes0point1,
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
