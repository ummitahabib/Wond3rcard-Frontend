import 'package:flutter/material.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddUserAccount extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.defaultWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Information',
                    style: TextStyle(
                      color: Color(0xff3A3541),
                      fontFamily: 'Barlow',
                      fontSize: 22.78,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Mandatory information',
                    style: TextStyle(
                      color: Color(0xff89868D),
                      fontFamily: 'Barlow',
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size30),
              Row(
                children: [
                  CircleAvatar(),
                  SizedBox(width: size20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile photo',
                        style: TextStyle(
                          color: Color(0xff3A3541),
                          fontFamily: 'Barlow',
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'This will be displayed on the user’s profile.',
                        style: TextStyle(
                          color: Color(0xff89868D),
                          fontFamily: "Barlow",
                          fontSize: 14.22,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size30),
              CustomTextField(
                textColor: AppColors.grayScale600,
                type: TextFieldType.Email,
                text: 'Personal mail address',
                inputType: TextInputType.emailAddress,
                isRequired: true,
                hintText: 'eg. Example@gmail.com',
                textEditingController: emailController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
