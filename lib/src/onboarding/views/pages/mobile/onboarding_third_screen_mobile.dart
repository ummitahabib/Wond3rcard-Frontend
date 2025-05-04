import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

    final companyNameController = useTextEditingController();
    final jobTitleController = useTextEditingController();
    final websiteController = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.grayScale50,
          child: Stack(
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
                    const OnboardingThirdScreenTextDetails(),
                    const SizedBox(height: SpacingConstants.size100),
                    Padding(
                      padding: const EdgeInsets.all(SpacingConstants.size14),
                      child: ThirdScreenTextfield(
                        companyNameController: companyNameController,
                        onboardingNotifier: onboardingNotifier,
                        jobTitleController: jobTitleController,
                        websiteController: websiteController,
                      ),
                    ),
                    const Spacer(),
                    ContinueWidget(
                      onTap: () {
                        context.go(RouteString.secondScreen);
                      },
                      textColor: AppColors.defaultWhite,
                      bgColor: AppColors.primaryShade,
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
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          SpacingConstants.sizes0point1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
