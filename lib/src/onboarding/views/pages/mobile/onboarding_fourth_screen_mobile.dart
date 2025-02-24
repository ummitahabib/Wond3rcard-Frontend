import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/onboarding/data/controller/onboarding_controller.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_screen_title_widget.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'dart:io' show File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;


class OnboardingFourthScreenMobile extends ConsumerStatefulWidget {
  const OnboardingFourthScreenMobile({super.key});

  @override
  _OnboardingFourthScreenMobileState createState() =>
      _OnboardingFourthScreenMobileState();
}

class _OnboardingFourthScreenMobileState
    extends ConsumerState<OnboardingFourthScreenMobile> {
  @override
  Widget build(BuildContext context) {
    final onboardingController = ref.watch(onboardingProvider);

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
                  horizontal: SpacingConstants.size10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const OnboardingScreenTitleText(
                      text: finallyAddAprofilePictureText,
                    ),
                    const SizedBox(
                      height: SpacingConstants.size100,
                    ),
                    uploadPhotoMethod(
                        onboardingController: onboardingController),
                    const Spacer(),
                    ContinueWidget(
                      onTap: () {
                        context.go(RouteString.thirdScreen);
                      },
                      textColor: AppColors.defaultWhite,
                      onPress: () {
                        context.go(RouteString.fifthScreen);
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






GestureDetector uploadPhotoMethod({
  required OnboardingModelNotifier onboardingController,
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap ?? onboardingController.pickImage,
    child: Center(
      child: onboardingController.uploadedImage != null
          ? SizedBox(
              width: SpacingConstants.size200,
              height: SpacingConstants.size200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SpacingConstants.size100),
                child: kIsWeb
                    ? FutureBuilder<Uint8List>(
                        future: onboardingController.getImageBytes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            return Image.memory(
                              snapshot.data!,
                              width: SpacingConstants.size250,
                              height: SpacingConstants.size200,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return Image.asset(
                              ImageAssets.profileImage,
                              width: SpacingConstants.size250,
                              height: SpacingConstants.size200,
                            );
                          }
                        },
                      )
                    : Image.file(
                        File(onboardingController.uploadedImage!.path),
                        width: SpacingConstants.size250,
                        height: SpacingConstants.size200,
                        fit: BoxFit.cover,
                      ),
              ),
            )
          : Image.asset(
              ImageAssets.profileImage,
              width: SpacingConstants.size250,
              height: SpacingConstants.size200,
            ),
    ),
  );
}

