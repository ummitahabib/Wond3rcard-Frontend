import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/admin/admin_subscription/data/models/admin_sub_model.dart';
import 'package:wond3rcard/src/utils/ui_data.dart';
import 'package:wond3rcard/src/utils/util.dart';

class CardPerfomanceAnalytics extends ConsumerWidget {
  const CardPerfomanceAnalytics({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(left: 20, right: 20),
                          height: 189,
                          
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: subscriptionAnalyticsData.length,
                            itemBuilder: (context, index) {
                              return _subscriptionAnalytics(
                                  subscriptionAnalyticsData[index]);
                            },
                          ),
                        );
  }
}



Widget _subscriptionAnalytics(AdminSubscriptionModel subscription) {
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
