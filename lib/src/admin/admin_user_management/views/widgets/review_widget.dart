import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReviewAccount extends HookConsumerWidget {



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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  reuseableHeaderWidget(
                    number: '1',
                    text: 'User Information',
                    activeColor: AppColors.primaryShade200,

                  ),

                    reuseableHeaderWidget(
                    number: '2',
                    text: 'Account Settings',
                    activeColor: AppColors.primaryShade200,
                    
                  ),

                   reuseableHeaderWidget(
                    number: '3',
                    text: 'Additional Information',
                    activeColor: AppColors.primaryShade200,
                    
                  ),


                     reuseableHeaderWidget(
                    number: '4',
                    text: 'Review',
                    activeColor: AppColors.primaryShade,
                    
                  ),
                ],)
           ),

            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.defaultWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(57),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  
                  
                  
            reusableHeaderText(),

                        SizedBox(height: 25,),
                        Row(
                          children: [
                            textWidget(text: 'First name'),
                            SizedBox(width: 20),
                            userDataWidget(text: 'umeeta'),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            textWidget(text: 'Surname'),
                            SizedBox(width: 20),
                            userDataWidget(text: 'habib'),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            textWidget(text: 'Personal email'),
                            SizedBox(width: 20),
                            userDataWidget(),
                          ],
                        ),
SizedBox(height: 15,),
                        Row(
                          children: [
                            textWidget(text: 'Phone number'),
                            SizedBox(width: 20),
                            userDataWidget(text: '08087787852'),
                          ],
                        ),
                      ],
                    ),


SizedBox(width: 70,),

                   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  
                  
                  
            reusableHeaderText(text: 'Account Setings'),

                        SizedBox(height: 25,),
                        Row(
                          children: [
                            textWidget(text: 'User Type'),
                            SizedBox(width: 20),
                            userDataWidget(text: 'Basic'),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            textWidget(text: 'Account Status:'),
                            SizedBox(width: 20),
                            userDataWidget(text: 'Active'),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            textWidget(text: 'Email Notification:'),
                            SizedBox(width: 20),
                            userDataWidget(text: 'Allow'),
                          ],
                        ),
SizedBox(height: 15,),
                        Row(
                          children: [
                            textWidget(text: 'Card limit: '),
                            SizedBox(width: 20),
                            userDataWidget(text: '5 Default'),
                          ],
                        ),
                      ],
                    ),
              SizedBox(width: 70,),


                        Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  
                  
                  
            reusableHeaderText(text: 'Additional Information'),

                        SizedBox(height: 25,),
                        Row(
                          children: [
                            textWidget(text: 'Company Name:'),
                            SizedBox(width: 20),
                            userDataWidget(text: 'Workable'),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            textWidget(text: 'Job Title:'),
                            SizedBox(width: 20),
                            userDataWidget(text: 'Designer'),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            textWidget(text: 'Industry:'),
                            SizedBox(width: 20),
                            userDataWidget(text: 'Tech'),
                          ],
                        ),
                      ],
                    ),
                            
                  ],
                ),
              ),
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
                          
                          onPressed: (){
                            context.go(RouteString.additionalInformation);
                          },
                          text: 'Back',
                          trailingIcon: Icon(Icons.arrow_back_ios, color: AppColors.primaryShade,)
                        ),
                      )
                 , SizedBox(width: 20,),
                      SizedBox(
                        width: 166,
                        height: 50,
                        child: WonderCardButton(
                          textColor: Colors.white,
                          
                          onPressed: (){
                            context.go(RouteString.accountReview);
                          },
                          text: 'Create Account',
                          trailingIcon: Icon(Icons.arrow_forward_ios, color: AppColors.defaultWhite,)
                        ),
                      )
                  
                  
                    ],)
          ],
        ),
      ),
    );
  }

  Text userDataWidget({String? text}) {
    return Text(
                            text ??'Umeeta Habib',
                            style: WonderCardTypography.regularTextTitle2(
                              color: Color(0xff3A3541), fontSize: 16
                            )
                          );
  }

  Text textWidget({String? text}) {
    return Text(
                            text ?? 'First Name : ',
                            style: WonderCardTypography.boldTextTitle2(
                              color: Color(0xff3A3541), fontSize: 16
                            )
                          );
  }

  Text reusableHeaderText({String? text}) {
    return Text(
                       text ?? 'User Information',
                        style: TextStyle(
                          color: Color(0xff3A3541),
                          fontFamily: 'Barlow',
                          fontSize: 23,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      );
  }

  Row reuseableHeaderWidget({
  String? number, 
  String? text,
  Color? activeColor,
  }) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 30, height: 30, decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: activeColor ?? AppColors.primaryShade,
                ),
                child: Center(child: Text(number ?? emptyString, style: WonderCardTypography.titleH6(
                  color: Colors.white, fontSize: 18
                ),)),
                ),
                SizedBox(width: 15,),
                Text(text ?? emptyString, style: WonderCardTypography.headlineH3(
                  color: activeColor ?? AppColors.primaryShade, 
                ))
              ],
            );
  }
}
