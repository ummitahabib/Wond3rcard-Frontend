import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/profile/views/pages/mobile/profile_mobile.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class EditProfileMobile extends HookConsumerWidget {
  
  const EditProfileMobile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final adminUserController = ref.read(profileProvider);
    
        useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final adminUserController = ref.read(profileProvider);
         
            Future.delayed(Duration.zero, () async {
              await adminUserController.getProfile();
            });
          
        });
        return null;
      },
      [],
    );
    
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            width: 40,
            height: SpacingConstants.size40,
            decoration: BoxDecoration(
                color: AppColors.defaultWhite,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.grayScale,
              ),
            ),
          ),
          actions: [
            Text(
              'Edit Profile',
              style: WonderCardTypography.boldTextH5(
                fontSize: 23,
                color: AppColors.grayScale,
              ),
            )
          ],
        ),
        backgroundColor: AppColors.grayScale50,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableProfileHeader(
                profile: adminUserController.profileData!,
              ),
              Column(
                children: [
                  CustomTextField(
                    hintText: 'example@gmail.com',
                    text: 'Personal Email',
                  ),
                  CustomTextField(
                    hintText: 'john',
                    text: 'Lastname',
                  ),
                  CustomTextField(
                    hintText: 'Doe',
                    text: 'Firstname',
                  ),
                  CustomTextField(
                    hintText: '+234 810000000',
                    text: 'Phone Number',
                  ),
                ],
              ),
              Row(
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
                        color: AppColors.defaultWhite,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text('Save Changes',
                          style: WonderCardTypography.boldTextTitleBold(
                            fontSize: SpacingConstants.size18,
                            color: AppColors.primaryShade,
                          )),
                    ),
                  ),
                ],
              )
            ]));
  }
}
