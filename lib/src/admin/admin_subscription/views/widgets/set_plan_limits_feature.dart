import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/reusbale_header_widget.dart';
import 'package:wond3rcard/src/privacy_security/views/pages/mobile/privacy_security_mobile.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/util.dart';

class SetPlanLimitsFeature extends ConsumerWidget {


final String routeName = RouteString.planLimitFeatures;

  const SetPlanLimitsFeature({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
  return Scaffold(
    backgroundColor: AppColors.grayScale50,
    body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
            GestureDetector(
                          onTap: (){
                  
                          },
                          child: reusableBackIcon()),
                          SizedBox(width: 20),
                        Text('Create New Subscription plan', style: WonderCardTypography.headlineH2(fontSize: 25, color: AppColors.primaryShade))
                    
              ],
            )
               , SizedBox(height: 28,),
                  
                  Text('Monitor and manage all Subscription in the system', style: WonderCardTypography.boldTextTitleBold(
                  fontSize: 18, color: Color(0xff3A3541),
                  
                  )),
                  
                  SizedBox(height: 30,),
                  
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
                                text: 'Basic Plan Information',
                                activeColor: AppColors.primaryShade,
            
                              ),
            
                                reuseableHeaderWidget(
                                number: '2',
                                text: 'Set Plan Limits & Features',
                                activeColor: AppColors.primaryShade,
                                
                              ),
            
                               reuseableHeaderWidget(
                                number: '3',
                                text: 'Review & Confirm',
                                activeColor: AppColors.primaryShade200,
                                
                              ),
                            ],)
                       ),
            
                  
                  SizedBox(height: 20,),
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
                                      'Set Plan Limits & Features',
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
                           
                               Column(
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.all(30),
                                     child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                       children: [
                                         reuseableCheckBox(
                                          text1: 'Analytics',
                                          text2: 'Multiple Card Creation',
                                         ),
                                         Divider(),
                                           reuseableCheckBox(
                                            text1: 'Custom Branding',
                                            text2: 'Analytics',
                                           ),
                                         Divider(),
                                           reuseableCheckBox(
                                            text1: 'Analytics',
                                            text2: 'Project Planning',
                                           ),
                                         Divider(),
                                          reuseableCheckBox(
                                            text1: 'Analytics',
                                            text2: 'Project Planning',
                                           ),
                                         Divider(),
                                       ],
                                     ),
                                   ),
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
                                      
                                      onPressed: (){
                                        context.go(RouteString.createNewSubscription);
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
                                        context.go(RouteString.subscriptionReview);
                                      },
                                      text: 'Next',
                                      trailingIcon: Icon(Icons.arrow_forward_ios, color: AppColors.defaultWhite,)
                                    ),
                                  )
                              
                              
                                ],)
                               
                              ],
                            ),
                          ),
                        )
          ]
        ),
      ),
    )
  );
  }

  Row reuseableCheckBox({String? text1, String? text2}) {
    return Row(
                                       children: [
                                         Row(children: [
                                          Text(text1 ?? emptyString, style: WonderCardTypography.boldTextTitle2(
                                            color: Color(0xff18181B), fontSize: 16,),),
                                            SizedBox(width: 100,),
                                            SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: Checkbox.adaptive(value: true, onChanged: (bool? newValue) {}))
                                         ],),
                                    
                                    Spacer(),
                                      Row(children: [
                                          Text(text2 ?? emptyString, style: WonderCardTypography.boldTextTitle2(
                                            color: Color(0xff18181B), fontSize: 16,),),
                                            SizedBox(width: 100,),
                                            SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: Checkbox.adaptive(value: true, onChanged: (bool? newValue) {}))
                                         ],),
                                    
                                    
                                       ],
                                     );
  }
  }