import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/create_account_custom_drop_down.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/reusbale_header_widget.dart';
import 'package:wond3rcard/src/privacy_security/views/pages/mobile/privacy_security_mobile.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/util.dart';

class CreateNewSubscriptionPlan extends ConsumerWidget {

final String routeName = RouteString.createNewSubscription;

  const CreateNewSubscriptionPlan({super.key});




  @override


  
  Widget build(BuildContext context, WidgetRef ref) {
  return Scaffold(
    backgroundColor: AppColors.grayScale50,
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(children: [
               GestureDetector(
                onTap: (){
        
                },
                child: reusableBackIcon()),
                SizedBox(width: 20),
              Text('Create New Subscription plan', style: WonderCardTypography.headlineH2(fontSize: 25, color: AppColors.primaryShade))
        
            
        
        
             
            ],),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children:[
                   SizedBox(height: 28,),
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
                      activeColor: AppColors.primaryShade200,
                      
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
                            'Basic Plan Information',
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
                          type: TextFieldType.defaultType,
                          text: 'Plan name',
                          inputType: TextInputType.emailAddress,
                          isRequired: true,
                          hintText: 'Eg. Premium',
                                       ),
                       ),
                    
                    SizedBox(height: 16,),
                     
                     
                     
                    Text(
                            'Billing Options',
                            style: TextStyle(
                              color: Color(0xff89868D),
                              fontFamily: 'Barlow',
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                     
                    SizedBox(height: 19,),
                     
            Row(
              children: [
                SizedBox(
                              width: 185,
                             child: CustomTextField(
                              textColor: AppColors.grayScale600,
                              type: TextFieldType.defaultType,
                              text: 'Billing Cycle ',
                              inputType: TextInputType.emailAddress,
                              isRequired: true,
                              hintText: 'Yearly',
                                           ),
                           ),
                           SizedBox(width: 28,),
                     
                           SizedBox(
                            width: 185,
                            child:
                            
                            Column(children: [
                              Text('Price', style: TextStyle(
                                fontFamily: 'Barlow',
                     fontWeight: FontWeight.w400,
                     fontSize: 14.22, color: Color(0xff3A3541),
                     
                              ),),
                               CustomDropdown(selectedValue: '9,900', options: [])
                            ],)
                            
                            )
              ],
            ),
                     
                     
              SizedBox(height: 10,),
              
            Row(
              children: [
                SizedBox(
                              width: 185,
                             child: CustomTextField(
                              textColor: AppColors.grayScale600,
                              type: TextFieldType.defaultType,
                              text: 'Billing Cycle',
                              inputType: TextInputType.emailAddress,
                              isRequired: true,
                              hintText: 'Monthly',
                                           ),
                           ),
                           SizedBox(width: 28,),
                     
                           SizedBox(
                            width: 185,
                            child:
                            
                            Column(children: [
                              Text('Price', style: TextStyle(
                                fontFamily: 'Barlow',
                     fontWeight: FontWeight.w400,
                     fontSize: 14.22, color: Color(0xff3A3541),
                     
                              ),),
                               CustomDropdown(selectedValue: '9,900', options: [])
                            ],)
                            
                            )
              ],
            ),
                
                          ],
                        )
                    
                    ,
                    Spacer(),
                     Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                          children: [
                     
                     
                     
                     
                  
                     
                       SizedBox(
                          width: 354,
                         child: CustomTextField(
                          textColor: AppColors.grayScale600,
                          type: TextFieldType.defaultType,
                          text: 'Description',
                          inputType: TextInputType.emailAddress,
                          isRequired: true,
                          hintText: 'For professionals who want full control, insights, and customization for their business cards. ',
                                       ),
                       ),
                     
                     
            SizedBox(
                          width: 354,
                         child: CustomTextField(
                          textColor: AppColors.grayScale600,
                          type: TextFieldType.defaultType,
                          text: 'Trial Period',
                          inputType: TextInputType.emailAddress,
                          isRequired: true,
                          hintText: '7 days',
                                       ),
                       ),
                     
                     SizedBox(height: 23,),
                     
                     Text('Auto Renewal', style: WonderCardTypography.bodyLarge(
                     color: Color(0xff3A3541),
                     fontSize: 14.22,
                     
                     )),
                     SizedBox(height: 18,),
                     SizedBox(
             width: 50,
             height: 30,
             child: Switch.adaptive(
               
               value: true, onChanged: (bool value){}),
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
                              context.go(RouteString.addUserAccount);
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
                              context.go(RouteString.planLimitFeatures);
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
                  
            ])
          ]
        ),
      ),
    )
  );
  }
  }