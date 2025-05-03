import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/desktop_onboarding_constant_widget.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/onboarding/data/controller/onboarding_controller.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_thirdscreen_text_details.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/third_screen_textfield.dart';



class OnboardingSecondScreenDesktop extends HookConsumerWidget {
  const OnboardingSecondScreenDesktop({super.key});
  final String routeName = RouteString.secondScreenDesktop;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingNotifier = ref.read(onboardingProvider);

    final TextEditingController companyNameController = TextEditingController();
    final TextEditingController jobTitleController = TextEditingController();
    final TextEditingController websiteController = TextEditingController();


    useEffect(() {
      final authController = ref.read(authProvider);
      authController.checkLoginStatus(context);
      return null;
    }, []);

    return Scaffold(
        body: Row(
      children: [
        Expanded(
           flex: 2,
          child: getStartedStack(context)),
         Spacer(),
        Expanded(
           flex: 3,
          child:      Container(
             padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(50),
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
                    context.go(RouteString.thirdScreenDesktop);
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
           
   
        )
      ],
    ));
  }
}









