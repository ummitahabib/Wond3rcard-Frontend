import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/data/controller/onboarding_controller.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_thirdscreen_text_details.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/third_screen_textfield.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class OnboardingThirdScreenMobile extends HookConsumerWidget {
  const OnboardingThirdScreenMobile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingNotifier = ref.read(onboardingProvider);

    final TextEditingController companyNameController = TextEditingController();
    final TextEditingController jobTitleController = TextEditingController();
    final TextEditingController websiteController = TextEditingController();

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
                    const SizedBox(child: OnboardingThirdScreenTextDetails()),
                    const SizedBox(
                      height: SpacingConstants.size100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        SpacingConstants.size14,
                      ),
                      child: ThirdScreenTextfield(
                          companyNameController: companyNameController,
                          onboardingNotifier: onboardingNotifier,
                          jobTitleController: jobTitleController,
                          websiteController: websiteController),
                    ),
                    const Spacer(),
                    ContinueWidget(
                      onTap: () {
                        context.go(RouteString.secondScreen);
                      },
                      textColor: AppColors.defaultWhite,
                      onPress: () async {
                        await StorageUtil.putString(
                          key: OnboardingString.companyName,
                          value: companyNameController.text,
                        );
                        await StorageUtil.putString(
                          key: OnboardingString.jobTitle,
                          value: jobTitleController.text,
                        );
                        await StorageUtil.putString(
                          key: OnboardingString.website,
                          value: websiteController.text,
                        );
                        context.go(RouteString.fourthScreen);
                      },
                      bgColor: AppColors.primaryShade,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          SpacingConstants.sizes0point1,
                    )
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
