import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/data/controller/onboarding_controller.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/first_onboarding_textfield.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_screen_title_widget.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_text_button.dart';


class OnboardingFirstScreenMobile extends HookConsumerWidget {
  const OnboardingFirstScreenMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingNotifier = ref.read(onboardingProvider);

    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.grayScale50,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _firstOnboardingStack(
            firstNameController,
            onboardingNotifier,
            lastNameController,
            context,
          ),
        ),
      ),
    );
  }

  Stack _firstOnboardingStack(
    TextEditingController firstNameController,
    OnboardingModelNotifier onboardingNotifier,
    TextEditingController lastNameController,
    BuildContext context,
  ) {
    return Stack(
      children: [
        Image.asset(ImageAssets.splashScreenOnboardFrame2),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SpacingConstants.size30,
            horizontal: SpacingConstants.size10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              onboardingTitle(firstScreenTitle, firstScreenTitle2),
              const SizedBox(height: SpacingConstants.size100),
              FirstOnboardingTextFields(
                firstNameController: firstNameController,
                lastNameController: lastNameController,
              ),
              const Spacer(),
              ContinueWidget(
                onTap: () {
                  context.go(RouteString.getStarted);
                },
                onPress: () async {
                  await StorageUtil.putString(
                    key: OnboardingString.firstName,
                    value: firstNameController.text,
                  );
                  await StorageUtil.putString(
                    key: OnboardingString.lastName,
                    value: lastNameController.text,
                  );
                  context.go(RouteString.secondScreen);
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(),
                  const Spacer(),
                  WonderCardTextButton(
                    onPressed: () {
                      context.go(RouteString.logIn);
                    },
                    text: skipText,
                    color: AppColors.primaryShade,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    SpacingConstants.sizes0point1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Column onboardingTitle(String text1, String text2) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      OnboardingScreenTitleText(text: text1),
      OnboardingScreenTitleText(text: text2),
    ],
  );
}


