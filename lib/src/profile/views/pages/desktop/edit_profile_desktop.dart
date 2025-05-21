import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/data/controller/auth_controller.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/profile/views/pages/mobile/profile_mobile.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class EditProfileDesktop extends HookConsumerWidget {
  const EditProfileDesktop({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.read(profileProvider);
    final authController = ref.read(authProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final userProfile = ref.read(profileProvider);

          Future.delayed(Duration.zero, () async {
            await userProfile.getProfile(context);
          });
        });
        return null;
      },
      [],
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              context.go(
                RouteString.profile,
              );
            },
            child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.grayScale,
              ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Edit Profile',
                style: WonderCardTypography.boldTextH5(
                  fontSize: 23,
                  color: AppColors.grayScale,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ReusableProfileHeader(
                      profile: userProfile.profileData!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: CustomTextField(
                            fillColor: AppColors.defaultWhite,
                            textColor: AppColors.grayScale600,
                            type: TextFieldType.Email,
                            text: 'Personal Email',
                            inputType: TextInputType.emailAddress,
                            hintText: userProfile
                                    .profileData?.payload?.profile.email ??
                                emptyString,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: CustomTextField(
                            fillColor: AppColors.defaultWhite,
                            textColor: AppColors.grayScale600,
                            type: TextFieldType.defaultType,
                            text: 'Last name',
                            inputType: TextInputType.name,
                            hintText: userProfile
                                    .profileData?.payload?.profile.lastname ??
                                emptyString,
                            textEditingController:
                                authController.lastNameController,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: CustomTextField(
                            fillColor: AppColors.defaultWhite,
                            textColor: AppColors.grayScale600,
                            type: TextFieldType.defaultType,
                            text: 'First Name',
                            inputType: TextInputType.name,
                            hintText: userProfile
                                    .profileData?.payload?.profile.firstname ??
                                emptyString,
                            textEditingController:
                                authController.emailController,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: CustomTextField(
                            fillColor: AppColors.defaultWhite,
                            textColor: AppColors.grayScale600,
                            type: TextFieldType.defaultType,
                            text: 'Phone Number',
                            inputType: TextInputType.name,
                            hintText: userProfile.profileData?.payload?.profile
                                    .mobileNumber ??
                                emptyString,
                            textEditingController:
                                authController.emailController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 171,
                          height: 52,
                          decoration: BoxDecoration(
                              color: AppColors.defaultWhite,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text('Cancel',
                                style: WonderCardTypography.boldTextTitleBold(
                                  fontSize: SpacingConstants.size18,
                                  color: AppColors.grayScale400,
                                )),
                          ),
                        ),
                        Container(
                          width: 171,
                          height: 52,
                          decoration: BoxDecoration(
                              color: AppColors.primaryShade,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text('Save Changes',
                                style: WonderCardTypography.boldTextTitleBold(
                                  fontSize: SpacingConstants.size18,
                                  color: AppColors.defaultWhite,
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ));
  }
}
