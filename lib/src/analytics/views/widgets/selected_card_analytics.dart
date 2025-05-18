import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_wrap/smart_wrap.dart';
import 'package:wond3rcard/src/analytics/data/controller/analytics_controller.dart';
import 'package:wond3rcard/src/analytics/views/widgets/average_view_duration.dart';
import 'package:wond3rcard/src/analytics/views/widgets/chart_column.dart';
import 'package:wond3rcard/src/analytics/views/widgets/contact_engagement.dart';
import 'package:wond3rcard/src/analytics/views/widgets/geographical_distribution_chart.dart';
import 'package:wond3rcard/src/analytics/views/widgets/link_engagement_widget.dart';
import 'package:wond3rcard/src/analytics/views/widgets/radial_chart_bar.dart';
import 'package:wond3rcard/src/analytics/views/widgets/top_perfoming_card.dart';
import 'package:wond3rcard/src/analytics/views/widgets/viewer_type_widget.dart';
import 'package:wond3rcard/src/cards/data/controller/card_controller.dart';
import 'package:wond3rcard/src/home/views/widgets/name_and_job.dart';
import 'package:wond3rcard/src/home/views/widgets/upgrade_now_button.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
import 'package:wond3rcard/src/utils/util.dart';

class SelectedCardAnalytics extends HookConsumerWidget {
  const SelectedCardAnalytics({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardController = ref.read(cardProvider);
    final profileController = ref.watch(profileProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (cardController.getCardsResponse == null) {
          await cardController.getAllUsersCard();
          await profileController.getProfile(context);
        }
      });
      return null;
    }, []);
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // context.go(RouteString.analytics);
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: AppColors.defaultWhite,
                borderRadius: BorderRadius.circular(10)),
            child: const HeroIcon(
              HeroIcons.arrowLeft,
              color: AppColors.grayScale,
            ),
          ),
        ),
        title: Text('Card analytics'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: 357,
              height: 230,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primaryShade,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            userProfileImage(height: 65, width: 65),
                            SizedBox(
                              child: personalProfileTag(
                                text: cardController.getCardsResponse?.payload
                                        ?.cards?[index].cardType ??
                                    emptyString,
                              ),
                            ),
                            Column(
                              children: [
                                Text('Date Created',
                                    style:
                                        WonderCardTypography.regularTextTitle1(
                                            fontSize: 13, color: Colors.white)),
                                Text('20-10-2024',
                                    style: WonderCardTypography
                                        .regularTextTitle2Bold(
                                            fontSize: 13, color: Colors.white)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.defaultWhite,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.left,
                                      cardController.getCardsResponse?.payload
                                              ?.cards?[index].cardName ??
                                          emptyString,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Barlow',
                                        fontSize: 18.093,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.left,
                                      '${cardController.getCardsResponse?.payload?.cards?[index].firstName ?? emptyString} ${cardController.getCardsResponse?.payload?.cards?[index].lastName ?? emptyString}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Barlow',
                                        fontSize: 18.093,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              cardAnalyticsText(count: '203', text: 'Views'),
                              SizedBox(
                                width: 8,
                              ),
                              cardAnalyticsText(count: '11', text: 'Shares'),
                              SizedBox(
                                width: 8,
                              ),
                              cardAnalyticsText(count: '89', text: 'Link Taps'),
                              SizedBox(
                                width: 8,
                              ),
                              cardAnalyticsText(count: '1023', text: 'Links'),
                              SizedBox(
                                width: 8,
                              ),
                              cardAnalyticsText(
                                  count: '129', text: 'Connection'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ChartColumn(),
                SizedBox(height: 10),
                LinkEngagementList(),
                SizedBox(height: 10),
                ContactEngagement(),
                SizedBox(height: 10),
                AverageViewDuration(),
                SizedBox(height: 10),
                ViewerTypeWidget(),
                SizedBox(height: 10),
                GeographicalDistributionChart(),
                SizedBox(height: 10),
                TopPerformingCardWidget(),
                SizedBox(height: 10),
                RadialChartBar(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column cardAnalyticsText({String? text, String? count}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count ?? '203',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Barlow',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        Text(
          text ?? 'Views',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Barlow',
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
