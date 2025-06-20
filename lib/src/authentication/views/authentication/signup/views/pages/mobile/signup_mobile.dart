import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_screen_title_widget.dart';
import 'package:wond3rcard/src/preview_card/data/controller/preview_controller.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_text_button.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class SignUpMobile extends StatefulHookConsumerWidget {
  const SignUpMobile({super.key});

  @override
  ConsumerState<SignUpMobile> createState() => _SignUpMobileState();
}

class _SignUpMobileState extends ConsumerState<SignUpMobile> {
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
      body: Stack(
        children: [
          Image.asset(ImageAssets.splashScreenOnboardFrame2),
          Padding(
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
                  SignUpTextFields(authController: authController),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpTextFields extends StatelessWidget {
  const SignUpTextFields({super.key, required this.authController});

  final AuthNotifier authController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SpacingConstants.size14),
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
            showLoader: authController.loadingSignup,
            onTap: () {
              context.go(RouteString.logIn);
            },
            buttonText: continueText,
            bgColor: AppColors.grayScale200,
            onPress: () {
              context.go(RouteString.uploadPhoto);
            },
          ),
        ],
      ),
    );
  }
}
