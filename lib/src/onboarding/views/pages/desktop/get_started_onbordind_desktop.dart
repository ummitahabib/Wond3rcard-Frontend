import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/desktop_onboarding_constant_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/first_onboarding_textfield.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_text_button.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class GetStartedOnboardingScreenDesktop extends HookConsumerWidget {
  const GetStartedOnboardingScreenDesktop({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();

    useEffect(() {
      final authController = ref.read(authProvider);
      authController.checkLoginStatus(context);
      return null;
    }, []);

    return Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 2,
          child: getStartedStack(context)),
        Spacer(),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                    child: onboardingTitle(
                  firstScreenTitle,
                  firstScreenTitle2,
                )),
                Spacer(),
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
                    // ignore: use_build_context_synchronously
                    context.go(RouteString.firstScreenDesktop);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
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
        )
      ],
    ));
  }
}
