import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/reusbale_header_widget.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountSettings extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.grayScale50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xffFFFFFF)),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  Spacer(),
                  SizedBox()
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(40),
                margin: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.defaultWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    reuseableHeaderWidget(
                      number: '1',
                      text: 'User Information',
                      activeColor: AppColors.primaryShade200,
                    ),
                    reuseableHeaderWidget(
                      number: '2',
                      text: 'Account Settings',
                      activeColor: AppColors.primaryShade,
                    ),
                    reuseableHeaderWidget(
                      number: '3',
                      text: 'Additional Information',
                      activeColor: AppColors.primaryShade200,
                    ),
                    reuseableHeaderWidget(
                      number: '4',
                      text: 'Review',
                      activeColor: AppColors.primaryShade200,
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.defaultWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(57),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 354,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('User type',
                                      style: WonderCardTypography.bodyLarge(
                                        color: AppColors.grayScale,
                                      )),
                                  SizedBox(
                                    height: 13,
                                  ),
                                  UserTypeCustomDropdown(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Column(
                              children: [
                                Text('Email Notification',
                                    style: WonderCardTypography.bodyLarge(
                                      color: AppColors.grayScale,
                                    )),
                                SizedBox(
                                  height: 13,
                                ),
                                Switch.adaptive(
                                    value: true, onChanged: (bool value) {}),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 354,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('User Status',
                                      style: WonderCardTypography.bodyLarge(
                                        color: AppColors.grayScale,
                                      )),
                                  SizedBox(
                                    height: 13,
                                  ),
                                  UserTypeStatusDropDown(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: 354,
                              child: CustomTextField(
                                textColor: AppColors.grayScale600,
                                type: TextFieldType.defaultType,
                                text: 'Card Limit',
                                inputType: TextInputType.emailAddress,
                                isRequired: true,
                                hintText: '5 default',
                                textEditingController: emailController,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 166,
                          height: 50,
                          child: WonderCardButton(
                              backgroundColor: AppColors.grayScale50,
                              textColor: AppColors.primaryShade,
                              onPressed: () {
                                context.go(RouteString.addUserAccount);
                              },
                              text: 'Back',
                              trailingIcon: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.primaryShade,
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 166,
                          height: 50,
                          child: WonderCardButton(
                              textColor: Colors.white,
                              onPressed: () {
                                context.go(RouteString.additionalInformation);
                              },
                              text: 'Next',
                              trailingIcon: Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.defaultWhite,
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserTypeCustomDropdown extends StatefulWidget {
  const UserTypeCustomDropdown({super.key});

  @override
  State<UserTypeCustomDropdown> createState() => _UserTypeCustomDropdownState();
}

class _UserTypeCustomDropdownState extends State<UserTypeCustomDropdown> {
  String selectedValue = 'Basic';

  final List<String> options = ['Basic', 'Premium', 'Business'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354,
      height: 46,
      padding: const EdgeInsets.fromLTRB(15, 13, 15, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFDBDCDE),
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class UserTypeStatusDropDown extends StatefulWidget {
  const UserTypeStatusDropDown({super.key});

  @override
  State<UserTypeStatusDropDown> createState() => _UserTypeStatusDropDownState();
}

class _UserTypeStatusDropDownState extends State<UserTypeStatusDropDown> {
  String selectedValue = 'Active';

  final List<String> options = [
    'Active',
    'InActive',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354,
      height: 46,
      padding: const EdgeInsets.fromLTRB(15, 13, 15, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFDBDCDE),
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
