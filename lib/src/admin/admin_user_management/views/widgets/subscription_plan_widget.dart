import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/pages/desktop/admin_dashboard_desktop.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/create_account_custom_drop_down.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/wonder_card_textfield.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubscriptionPlanWidget extends HookConsumerWidget {



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
                    activeColor: AppColors.primaryShade,

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
                          'Subscription Plan',
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                               children: [
                                Text('Select Subscription Plan', style: TextStyle(
                                  fontFamily: 'Barlow',
fontWeight: FontWeight.w400,
fontSize: 14.22,
color: Color(0xff3A3541),

                                ),),
                                 CustomDropdown(
                                  options: ['organization', 'business'],
                                  selectedValue: 'organization',
                                 ),
                               ],
                             ),
                           ),
                  
                  SizedBox(height: 16,),
                        SizedBox(
                              width: 354,
                             child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                               children: [
                                Text('Payment status', style: TextStyle(
                                  fontFamily: 'Barlow',
fontWeight: FontWeight.w400,
fontSize: 14.22,
color: Color(0xff3A3541),

                                ),),
                                 CustomDropdown(
                                  options: ['paid', 'pending', 'try again'],
                                  selectedValue: 'paid',
                                 ),
                               ],
                             ),
                           ),
                  



                    SizedBox(height: 16,),
                        SizedBox(
                              width: 354,
                             child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                               children: [
                                Text('Payment method', style: TextStyle(
                                  fontFamily: 'Barlow',
fontWeight: FontWeight.w400,
fontSize: 14.22,
color: Color(0xff3A3541),

                                ),),
                                 CustomDropdown(
                                  options: ['cash', 'bank', 'transfer'],
                                  selectedValue: 'cash',
                                 ),
                               ],
                             ),
                           ),
                  



                    SizedBox(height: 16,),
                        SizedBox(
                              width: 354,
                             child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                               children: [
                                Text('Starting date', style: TextStyle(
                                  fontFamily: 'Barlow',
fontWeight: FontWeight.w400,
fontSize: 14.22,
color: Color(0xff3A3541),

                                ),),
                                 DatePickerWidget()
                               ],
                             ),
                           ),
                  
                 
                        ],
                      )
                  
                  ,
                 SizedBox(width: 80,),
                   Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(30),
                      decoration: BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: BorderRadius.circular(8), // Border radius
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000), // Shadow color (#00000026)
              offset: Offset(0, 0), // Shadow position
              blurRadius: 4, // Blur radius
            ),
          ],
        ),
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                          children: [
Text('230/Organisation', style: WonderCardTypography.headlineH1(



),), 

FittedBox(child: Text('For professionals who want full control, insights, and customization for their business cards.', style: WonderCardTypography.bodySmall(),),),

SizedBox(
  
  width: 290,
height: 32,
  child: WonderCardButton(text: 'Yearly Subscription', onPressed: (){})),


Column(children: [
  reusablePlanData(),
  SizedBox(height: 23,),
  reusablePlanData(text: 'Create multiple business cards'),
    SizedBox(height: 23,),
   reusablePlanData(text: 'Advanced Analytics ( geo-location, devices) etc'),
     SizedBox(height: 23,),
    reusablePlanData(text: 'Custom Branding (Logos, color themes, '),
      SizedBox(height: 23,),
      reusablePlanData(text: 'No Team Management'),
],)

                          ]
                        ),
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
                          textColor: Colors.white,
                          
                          onPressed: (){
                            context.go(RouteString.accountSettings);
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

  Row reusablePlanData({String? text }) {
    return Row(
  children: [
   Icon(Icons.mark_chat_read, color: AppColors.grayScale, size: 24,),
   SizedBox(width: 8,),
    Text( text ?? 'Everything in free plan', style: WonderCardTypography.textCaption()),
  ],
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







class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        width: 354,
        height: 46,
        padding: const EdgeInsets.fromLTRB(15, 13, 15, 16),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEFEF), // Background color
          borderRadius: BorderRadius.circular(8), // Border radius
          border: Border.all(
            color: const Color(0xFFDBDCDE), // Border color
            width: 1, // Border width
          ),
        ),
        child: TextField(
          controller: _dateController,
          readOnly: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Select Date',
            suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
