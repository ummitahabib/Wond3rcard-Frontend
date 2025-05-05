import 'package:flutter/material.dart';
import 'package:wond3rcard/src/onboarding/data/controller/onboarding_controller.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';

class ThirdScreenTextfield extends StatelessWidget {
  const ThirdScreenTextfield({
    super.key,
    required this.companyNameController,
    required this.onboardingNotifier,
    required this.jobTitleController,
    required this.websiteController,
  });

  final TextEditingController companyNameController;
  final OnboardingModelNotifier onboardingNotifier;
  final TextEditingController jobTitleController;
  final TextEditingController websiteController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          textEditingController: companyNameController,
          onChange: (value) async {
            await StorageUtil.putString(
                key: OnboardingString.companyName, value: value);
          },
          isRequired: true,
          hintColor: AppColors.lighDisable,
          textColor: AppColors.grayScale600,
          fillColor: AppColors.defaultWhite,
          hintText: companyName,
          text: enterCompanyName,
          type: TextFieldType.defaultType,
        ),
        CustomTextField(
          textEditingController: jobTitleController,
          onChange: (value) async {
            await StorageUtil.putString(
                key: OnboardingString.jobTitle, value: value);
          },
          isRequired: true,
          hintColor: AppColors.lighDisable,
          textColor: AppColors.grayScale600,
          fillColor: AppColors.defaultWhite,
          hintText: jobTitle,
          text: enterJobTitle,
          type: TextFieldType.defaultType,
        ),
        CustomTextField(
          textEditingController: websiteController,
          onChange: (value) async {
            await StorageUtil.putString(
                key: OnboardingString.website, value: value);
          },
          isRequired: true,
          hintColor: AppColors.lighDisable,
          textColor: AppColors.grayScale600,
          fillColor: AppColors.defaultWhite,
          hintText: companyWebsite,
          text: enterCompanyWebsite,
          type: TextFieldType.defaultType,
        ),
      ],
    );
  }
}
