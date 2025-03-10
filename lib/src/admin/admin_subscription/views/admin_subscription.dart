import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/admin/admin_cards/views/card_table.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/widgets/device_category.dart';
import 'package:wond3rcard/src/admin/admin_subscription/views/widgets/admin_subscription_plan.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';
import 'package:wond3rcard/src/utils/util.dart';

class AdminSubscription extends ConsumerWidget {
  const AdminSubscription({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SingleChildScrollView(
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
            width: 1253,
            height: 82,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  WonderCardButton(
                      onPressed: () {},
                      text: 'Add  New Plan',
                      backgroundColor: AppColors.primaryShade,
                      textColor: Colors.white,
                      buttonWidth: 160,
                      leadingIcon: HeroIcon(
                        HeroIcons.plus,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 17,
                  ),
                  WonderCardButton(
                      onPressed: () {},
                      text: 'Subscription Settings',
                      backgroundColor: AppColors.primaryShade,
                      textColor: Colors.white,
                      buttonWidth: 160,
                      leadingIcon: HeroIcon(
                        HeroIcons.plus,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 17,
                  ),
                  WonderCardButton(
                      onPressed: () {},
                      text: 'Manage User Subscription',
                      backgroundColor: AppColors.primaryShade,
                      textColor: Colors.white,
                      buttonWidth: 215,
                      leadingIcon: HeroIcon(
                        HeroIcons.plus,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableSubscriptionText('Subscription Plans'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: SubscriptionPlanTable()),
                     Expanded(
                      flex: 3,
                      child: DeviceCategory()),
                  ],
                )
              ],
            ),
          ),
          Container(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    reusableSubscriptionText('User Subscriptions'),
                CardTableScreen(),
            
              ],
            ),
          )
        ],
      ),
    )));
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
          color: Color(0xff3A3541),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
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
            HeroIcon(HeroIcons.arrowDownRight, color: Color(0xff212121))
          ],
        ),
      ),
    ),
  );
}

class AdminSubscriptionModel {
  final String title;
  final String value;

  AdminSubscriptionModel({required this.title, required this.value});
}

// Sample data list
List<AdminSubscriptionModel> adminSubscriptions = [
  AdminSubscriptionModel(title: 'Total Users', value: '302'),
  AdminSubscriptionModel(title: 'Premium Users', value: '59'),
  AdminSubscriptionModel(title: 'Business Users', value: '99'),
  AdminSubscriptionModel(title: 'Active Plans', value: '003'),
  AdminSubscriptionModel(title: 'Monthly Revenue', value: '882'),
];
