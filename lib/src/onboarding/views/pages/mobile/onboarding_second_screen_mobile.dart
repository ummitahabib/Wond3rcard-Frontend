import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_screen_title_widget.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:go_router/go_router.dart';

class OnboardingSecondScreenMobile extends HookConsumerWidget {
  const OnboardingSecondScreenMobile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController workEmailController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.grayScale50,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
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
                    const SizedBox(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        OnboardingScreenTitleText(
                          text: howCanPeopleReachYouText,
                        ),
                        OnboardingScreenTitleText(
                          text: atWorkText,
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: SpacingConstants.size100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(SpacingConstants.size14),
                      child: Column(
                        children: [
                          CustomTextField(
                            textEditingController: workEmailController,
                            onChange: (value) async {
                              await StorageUtil.putString(
                                  key: OnboardingString.workEmail,
                                  value: value);
                            },
                            isRequired: true,
                            hintColor: AppColors.lighDisable,
                            textColor: AppColors.grayScale600,
                            fillColor: AppColors.defaultWhite,
                            hintText: workEmail,
                            text: enterWorkEmail,
                            type: TextFieldType.Email,
                          ),
                          CustomTextField(
                            inputType: TextInputType.phone,
                              textEditingController: phoneNumberController,
                              onChange: (value) async {
                                await StorageUtil.putString(
                                    key: OnboardingString.phoneNumber,
                                    value: value);
                              },
                              isRequired: true,
                              hintColor: AppColors.lighDisable,
                              textColor: AppColors.grayScale600,
                              fillColor: AppColors.defaultWhite,
                              hintText: '+234 123 456 78',
                              text: enterPhoneNumber,
                              type: TextFieldType.Number),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ContinueWidget(
                      onTap: () {
                        context.go(RouteString.firstScreen);
                      },
                      textColor: AppColors.defaultWhite,
                      onPress: () async {
                        await StorageUtil.putString(
                          key: OnboardingString.workEmail,
                          value: workEmailController.text,
                        );
                        await StorageUtil.putString(
                          key: OnboardingString.phoneNumber,
                          value: phoneNumberController.text,
                        );
                        // ignore: use_build_context_synchronously
                        context.go(
                          RouteString.thirdScreen,
                        );
                      },
                      bgColor: AppColors.primaryShade,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          SpacingConstants.sizes0point1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
