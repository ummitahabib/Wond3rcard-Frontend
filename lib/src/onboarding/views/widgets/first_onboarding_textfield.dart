import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/onboarding/data/controller/onboarding_controller.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';

class FirstOnboardingTextFields extends StatelessWidget {
  const FirstOnboardingTextFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SpacingConstants.size14),
      child: Column(
        children: [
          CustomTextField(
            textEditingController: firstNameController,
            onChange: (value) async {
              await StorageUtil.putString(
                  key: OnboardingString.firstName, value: value);
              final savedFirstName =
                  StorageUtil.getString(key: OnboardingString.firstName);
              print('This is the first name: $savedFirstName');
            },
            isRequired: true,
            hintColor: AppColors.lighDisable,
            textColor: AppColors.grayScale600,
            fillColor: AppColors.defaultWhite,
            hintText: firstName,
            text: enterFirstName,
            type: TextFieldType.defaultType,
          ),
          CustomTextField(
            textEditingController: lastNameController,
            onChange: (value) async {
              await StorageUtil.putString(
                  key: OnboardingString.lastName, value: value);
              final savedLastName =
                  StorageUtil.getString(key: OnboardingString.lastName);
              print('This is the last name: $savedLastName');
            },
            isRequired: true,
            hintColor: AppColors.lighDisable,
            textColor: AppColors.grayScale600,
            fillColor: AppColors.defaultWhite,
            hintText: lastName,
            text: enterLastName,
            type: TextFieldType.defaultType,
          ),
        ],
      ),
    );
  }
}
