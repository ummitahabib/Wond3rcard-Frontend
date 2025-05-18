import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_text_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class LoginTextField extends HookConsumerWidget {
  const LoginTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authProvider);

    SizedBox wonderCardLoginButton(BuildContext context) {
      return SizedBox(
        width: size360,
        child: WonderCardButton(
            showLoader: authController.loadingLogin,
            loadererColor: AppColors.defaultWhite,
            textColor: AppColors.defaultWhite,
            text: loginText,
            onPressed: () {
              try {
                authController.signInMethod(context);
                ();
              } catch (e) {
                debugPrint('Login error: $e');
              }
            }),
      );
    }

    CustomTextField emailTextField() {
      return CustomTextField(
        textColor: AppColors.grayScale600,
        type: TextFieldType.Email,
        text: enterYourEmailText,
        inputType: TextInputType.emailAddress,
        isRequired: true,
        hintText: exampleEmailText,
        textEditingController: authController.emailController,
      );
    }

    CustomTextField passwordTextField() {
      return CustomTextField(
        textColor: AppColors.grayScale600,
        text: enterYourPasswordText,
        type: TextFieldType.Password,
        inputType: TextInputType.visiblePassword,
        isRequired: true,
        hintText: password,
        textEditingController: authController.passwordController,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              emailTextField(),
              passwordTextField(),
            ],
          ),
        ),
        const SizedBox(
          height: SpacingConstants.size30,
        ),
        wonderCardLoginButton(context),
        const SizedBox(
          height: SpacingConstants.size8,
        ),
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WonderCardTextButton(
                onPressed: () {
                  context.go(RouteString.signup);
                },
                text: signUpText,
                color: AppColors.primaryShade,
              ),
              WonderCardTextButton(
                text: forgetPasswordText,
                onPressed: () {
                  context.go(RouteString.resetPassword);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
