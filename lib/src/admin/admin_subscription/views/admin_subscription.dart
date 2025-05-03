import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/admin/admin_cards/views/card_table.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/widgets/device_category.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_sub_model.dart';
import 'package:wond3rcard/src/admin/admin_subscription/views/widgets/admin_subscription_plan.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/recently_created_main_widget.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/util.dart';

class AdminSubscription extends ConsumerWidget {
  const AdminSubscription({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return 
    
    Scaffold(
        body: adminSubscriptionBody(context));
  }

  SingleChildScrollView adminSubscriptionBody(BuildContext context) {
    return SingleChildScrollView(
          child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: adminSubscriptions
                .map(
                    (subscription) => reusableAdminSubscription(subscription))
                .toList(),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.only(left: 40, top: 30, bottom: 30),
          
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              WonderCardButton(
                  onPressed: () {
                    context.go(RouteString.createSubscription);
                  },
                  text: 'Add  New Plan',
                  backgroundColor: AppColors.primaryShade,
                  textColor: Colors.white,
               
                  leadingIcon: HeroIcon(
                    HeroIcons.plus,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 17,
              ),
              WonderCardButton(
                  onPressed: () {
                    context.go(RouteString.suscriptionSettings);
                  },
                  text: 'Subscription Settings',
                  backgroundColor: AppColors.primaryShade,
                  textColor: Colors.white,
                
                  leadingIcon: HeroIcon(
                    HeroIcons.plus,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 17,
              ),
              WonderCardButton(
                  onPressed: () {

                       context.go(RouteString.manageUserSubscription);
                  },
                  text: 'Manage User Subscription',
                  backgroundColor: AppColors.primaryShade,
                  textColor: Colors.white,
                
                  leadingIcon: HeroIcon(
                    HeroIcons.plus,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableSubscriptionText('Subscription Plans'),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: SubscriptionPlanTable()),
                   Expanded(
                    flex: 3,
                    child: RecentlyCreatedMainWidget()),
                ],
              )
            ],
          ),
        ),
        
      ],
    ),
  ));
  }

  Text reusableSubscriptionText(String text) {
    return Text(
      text,
      style: WonderCardTypography.boldTextH5(
        color: Color(0xff3A3541),
        fontSize: 23,
      ),
    );
  }
}

Widget reusableAdminSubscription(AdminSubscriptionModel subscription) {
  return InkWell(
    child: Container(
      width: 230,
      decoration: BoxDecoration(
        color: AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: AppColors.defaultWhite,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
         mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 27,
                      height: 27,
                      decoration: BoxDecoration(
                          color: Color(0xffDECCFE),
                          borderRadius: BorderRadius.circular(7)),
                      child: Center(
                        child: HeroIcon(
                          HeroIcons.userGroup,
                          color: AppColors.primaryShade,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(subscription.title,
                        style: TextStyle(
                          color: Color(0xff3A3541),
                          fontFamily: 'Barlow',
                          fontSize: 14.522,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
                Text(
                  subscription.value,
                  style: TextStyle(
                    color: Color(0xff3A3541),
                    fontFamily: 'Barlow',
                    fontSize: 43.566,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios,color: Color(0xff212121) )
          ],
        ),
      ),
    ),
  );
}
