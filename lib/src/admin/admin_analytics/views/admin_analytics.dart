import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/widgets/active_subscription_growth.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/widgets/cancellation_reason.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/widgets/card_performance_analytics.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/widgets/card_state_table.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/widgets/device_insight.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/widgets/revenue_analytics.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/widgets/revenue_growth.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/widgets/subscription_analytics.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/widgets/subscription_trend_chart.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/widgets/system_activity_log.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/widgets/user_analytics.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/add_user_widget.dart';
import 'package:wond3rcard/src/analytics/views/widgets/most_view_cards.dart';
import 'package:wond3rcard/src/shared/views/widgets/modal_actions.dart';
import 'package:wond3rcard/src/admin/admin_subscription/views/admin_subscription.dart';
import 'package:wond3rcard/src/utils/util.dart';

class AdminAnalytics extends HookConsumerWidget {
  const AdminAnalytics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            analyticsHeader(context),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            height: 189,
                            child: GridView.builder(
                            
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                childAspectRatio: 1.5,
                              ),
                              itemCount: analyticsData.length,
                              itemBuilder: (context, index) {
                                return reusableAdminSubscription(
                                    analyticsData[index]);
                              },
                            ),
                          ),
                        ),
                        RevenueGrowthChart()
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(flex: 4, child: DeviceInsight()),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SubscriptionTrendChart(),
                SizedBox(
                  width: 20,
                ),
               SystemActivityLogWidget(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   Padding(
                    padding: const EdgeInsets.only(left: 30, right: 20),
                     child: Row(
                       children: [
                        Icon(
                          Icons.analytics_outlined,
                          color: AppColors.primaryShade),
                         Text(
                                      'Reveneue Analytics',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Barlow',
                                        color: Color(0xff3A3541),
                                      ),
                                    ),
                       ],
                     ),
                   ),
                              SizedBox(height: 8,),
                               RevenueAnalytics(),
            ],)
       , 


SizedBox(height: 10,),
  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   Padding(
                    padding: const EdgeInsets.only(left: 30, right: 20),
                     child: Row(
                       children: [
                        Icon(
                          Icons.subscriptions,
                          color: AppColors.primaryShade),
                         Text(
                                      'Subscription  Analytics',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Barlow',
                                        color: Color(0xff3A3541),
                                      ),
                                    ),
                       ],
                     ),
                   ),
                              SizedBox(height: 8,),
                               SubscriptionAnalytics(),
            ],),

       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
        
        children: [    Expanded(child: SubscriptionChart()),  Expanded(child:CancellationPieChart(data: cancellationData),),],),
   

  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   Padding(
                    padding: const EdgeInsets.only(left: 30, right: 20),
                     child: Row(
                       children: [
                        Icon(
                          Icons.supervised_user_circle_sharp,
                          color: AppColors.primaryShade),
                         Text(
                                      'User Analytics',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Barlow',
                                        color: Color(0xff3A3541),
                                      ),
                                    ),
                       ],
                     ),
                   ),
                              SizedBox(height: 8,),
                               UserAnalytics(),
            ],)
       , 


  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   Padding(
                    padding: const EdgeInsets.only(left: 30, right: 20),
                     child: Row(
                       children: [
                        Icon(
                          Icons.card_membership_outlined,
                          color: AppColors.primaryShade),
                         Text(
                                      'Card Performance Analytics',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Barlow',
                                        color: Color(0xff3A3541),
                                      ),
                                    ),
                       ],
                     ),
                   ),
                              SizedBox(height: 8,),
                              CardPerfomanceAnalytics(),
            ],)
       , 

Row(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start, 
  mainAxisSize: MainAxisSize.min,

  children: [
    Expanded(child: CardStatsTable(stats: cardStatsList)),
    Expanded(child: MostViewCards()),
  ],
)

          
           
          ],
        ),
      ),
    );
  }

  Padding analyticsHeader(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                HeroIcon(
                  HeroIcons.userGroup,
                  color: Color(0xff0F172A),
                  size: 24,
                ),
                Text('/  Pages  /  Analytics /'),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    customDialog(context, AddUserAccount());
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFF6D41CA),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_document, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Export & Reports',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

BoxDecoration reusableContainerDeco() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color(0x26000000),
        blurRadius: 4,
        offset: Offset(0, 0),
      ),
    ],
  );
}
