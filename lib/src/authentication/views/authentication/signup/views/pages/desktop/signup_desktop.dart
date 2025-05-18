import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/desktop_onboarding_constant_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_screen_title_widget.dart';
import 'package:wond3rcard/src/preview_card/data/controller/preview_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_text_button.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class SignUpDesktop extends HookConsumerWidget {
  const SignUpDesktop({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 2, child: getStartedStack(context)),
          Spacer(),
          Expanded(flex: 3, child: SignUpData()),
        ],
      ),
    );
  }
}

class SignUpData extends StatefulHookConsumerWidget {
  const SignUpData({super.key});

  @override
  ConsumerState<SignUpData> createState() => _SignUpDataState();
}

class _SignUpDataState extends ConsumerState<SignUpData> {
  late final AuthNotifier authController;
  late final PreviewNotifier previewController;

  @override
  void initState() {
    super.initState();

    authController = ref.read(authProvider);
    previewController = ref.read(previewProvider);
    previewController.loadUserDetails();
    _initializeControllers();
  }

  void _initializeControllers() {
    authController.firstNameController.text =
        previewController.firstName?.isNotEmpty == true
            ? previewController.firstName!
            : '';

    authController.lastNameController.text =
        previewController.lastName?.isNotEmpty == true
            ? previewController.lastName!
            : '';
    authController.workMail.text =
        previewController.workEmail?.isNotEmpty == true
            ? previewController.workEmail!
            : '';

    authController.companyNameController.text =
        previewController.companyName?.isNotEmpty == true
            ? previewController.companyName!
            : '';

    authController.jobTitleController.text =
        previewController.jobTitle?.isNotEmpty == true
            ? previewController.jobTitle!
            : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: SpacingConstants.size80,
          horizontal: SpacingConstants.size10,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OnboardingScreenTitleText(text: createAnAccountToEdit),
                  OnboardingScreenTitleText(text: saveYourCard),
                ],
              ),
              const SizedBox(height: SpacingConstants.size40),
              SignUpTextFields(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpTextFields extends HookConsumerWidget {
  const SignUpTextFields({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authProvider);
    return Padding(
      padding: const EdgeInsets.all(SpacingConstants.size14),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: Column(
          children: [
            CustomTextField(
              type: TextFieldType.defaultType,
              text: enterFirstName,
              hintText: firstName,
              textEditingController: authController.firstNameController,
            ),
            CustomTextField(
              type: TextFieldType.defaultType,
              text: enterLastName,
              hintText: lastName,
              textEditingController: authController.lastNameController,
            ),
            CustomTextField(
              text: enterOtherName,
              hintText: otherName,
              textEditingController: authController.otherName,
            ),
            CustomTextField(
              type: TextFieldType.Email,
              inputType: TextInputType.emailAddress,
              text: enterPersonalEmail,
              hintText: personalEmail,
              textEditingController: authController.emailController,
            ),
            CustomTextField(
              type: TextFieldType.Email,
              inputType: TextInputType.emailAddress,
              text: enterWorkEmail,
              hintText: workEmail,
              textEditingController: authController.workMail,
            ),
            CustomTextField(
              type: TextFieldType.Password,
              text: enterPassword,
              hintText: password,
              textEditingController: authController.passwordController,
            ),
            CustomTextField(
              type: TextFieldType.Password,
              text: confirmPassword,
              hintText: password,
              textEditingController: authController.confirmPassword,
            ),
            CustomTextField(
              type: TextFieldType.defaultType,
              text: enterCompanyName,
              hintText: companyName,
              textEditingController: authController.companyNameController,
            ),
            CustomTextField(
              text: enterJobTitle,
              hintText: jobTitle,
              textEditingController: authController.jobTitleController,
            ),
            CustomTextField(
              type: TextFieldType.Number,
              inputType: TextInputType.phone,
              text: enterPhoneNumber,
              hintText: phoneNumber,
              textEditingController: authController.phoneNumberController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WonderCardTextButton(
                  onPressed: () {},
                  text: alreadyHaveAnaccountText,
                ),
                WonderCardTextButton(
                  color: AppColors.primaryShade,
                  text: signInText,
                  onPressed: () {
                    context.go(RouteString.logIn);
                  },
                ),
              ],
            ),
            ContinueWidget(
              showLoader: ref.watch(authProvider).loadingSignup,
              onTap: () {
                context.go(RouteString.logIn);
              },
              buttonText: signUpText,
              bgColor: AppColors.grayScale200,
              onPress: () {
                authController.signUp(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
