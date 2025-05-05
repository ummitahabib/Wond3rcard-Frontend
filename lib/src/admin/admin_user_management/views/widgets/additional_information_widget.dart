import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdditionalInformationWidget extends HookConsumerWidget {



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
                    activeColor: AppColors.primaryShade,
                    
                  ),


                     reuseableHeaderWidget(
                    number: '4',
                    text: 'Review',
                    activeColor: AppColors.primaryShade200,
                    
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
                             child: CustomTextField(
                                             textColor: AppColors.grayScale600,
                                             type: TextFieldType.Email,
                                             text: 'Company Information',
                                             inputType: TextInputType.emailAddress,
                                             isRequired: true,
                                             hintText: 'eg. Google',
                                             textEditingController: emailController,
                                           ),
                           ),
                  
                  SizedBox(height: 16,),
                     SizedBox(
                        width: 354,
                       child: CustomTextField(
                        textColor: AppColors.grayScale600,
                        type: TextFieldType.defaultType,
                        text: 'Industry',
                        inputType: TextInputType.emailAddress,
                        isRequired: true,
                        hintText: 'eg. Agriculture',
                        textEditingController: emailController,
                                     ),
                     ),
                 
                 
                        ],
                      )
                  
                  ,
                 SizedBox(width: 80,),
                   Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                        children: [
                           SizedBox(
                            width: 354,
                             child: CustomTextField(
                                             textColor: AppColors.grayScale600,
                                             type: TextFieldType.Email,
                                             text: 'Job title',
                                             inputType: TextInputType.emailAddress,
                                             isRequired: true,
                                             hintText: 'eg. Designer',
                                             textEditingController: emailController,
                                           ),
                           ),
                  
                  SizedBox(height: 16,),
                  
                     SizedBox(
                        width: 354,
                       child: CustomTextField(
                        textColor: AppColors.grayScale600,
                        type: TextFieldType.defaultType,
                        text: 'Office Address',
                        inputType: TextInputType.emailAddress,
                        isRequired: true,
                        hintText: 'eg. Ahmadu bello way',
                        textEditingController: emailController,
                                     ),
                     ),
                 
                 
                        ],
                      )
                  
                   
                   
                    ],),
                  
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
                            context.go(RouteString.accountSettings);
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
                          text: 'Next',
                          trailingIcon: Icon(Icons.arrow_forward_ios, color: AppColors.defaultWhite,)
                        ),
                      )
                  
                  
                    ],)
                   
                  ],
                ),
              ),
            ),
      
          ],
        ),
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
