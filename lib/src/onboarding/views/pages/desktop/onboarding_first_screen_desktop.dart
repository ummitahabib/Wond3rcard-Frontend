import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/continue_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/desktop_onboarding_constant_widget.dart';
import 'package:wond3rcard/src/onboarding/views/widgets/onboarding_screen_title_widget.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class OnboardingFirstScreenDesktop extends HookConsumerWidget {
  const OnboardingFirstScreenDesktop({super.key});
  final String routeName = RouteString.secondScreenDesktop;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   TextEditingController workEmailController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();

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
                    context.go(RouteString.getStarted);
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
                      RouteString.secondScreenDesktop,
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
           
   
        )
      ],
    ));
  }
}







