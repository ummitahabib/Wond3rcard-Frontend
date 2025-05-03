import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/data/controller/analytics_controller.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/util.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class TopPerformingCardWidget extends HookConsumerWidget {
  const TopPerformingCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsController = ref.watch(analyticsProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final analyticsController = ref.read(analyticsProvider);
          if (analyticsController.analytics == null) {
            Future.delayed(Duration.zero, () async {
              await analyticsController.getInteraction();
            });
          }
        });
        return null;
      },
      [],
    );

    return Flexible(child: card(context, analyticsController));
  }

  Widget card(BuildContext context, AnalyticsNotifier analyticsController) {
    return Container(
       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.defaultWhite,
            borderRadius: BorderRadius.circular(12),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Top Performing Cards',
            style: WonderCardTypography.boldTextTitleBold(
              fontSize: 18,
              color: AppColors.grayScale,
            ),
          ),
          Row(
               mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 16,
              ),
              Text(
                'Card name',
                style: WonderCardTypography.boldTextTitle2(
                  fontSize: 16,
                  color: AppColors.grayScale400,
                ),
              ),
              const Spacer(),
              Text(
                'Engagement Rate',
                style: WonderCardTypography.boldTextTitle2(
                  fontSize: 16,
                  color: AppColors.grayScale400,
                ),
              ),
            ],
          ),
          Container(
            height: 503,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: analyticsController.analytics?.payload.analytics
                  .topPerformingCards.topPerformingCards.length,
              itemBuilder: (context, index) {
                final card = analyticsController.analytics?.payload.analytics
                    .topPerformingCards.topPerformingCards[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          ImageAssets.crown,
                        ),
                        Text(
                          card?.cardName ?? emptyString,
                          style: WonderCardTypography.boldTextTitleBold(
                            fontSize: 18,
                            color: AppColors.grayScale,
                          ),
                        ),
                        Text(
                          '${card?.percentage ?? emptyString}%',
                          style: WonderCardTypography.boldTextH5(
                            fontSize: 23,
                            color: AppColors.grayScale,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          width: 280,
                          height: 66,
                          decoration: BoxDecoration(
                              color: AppColors.grayScale50,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              topPerformingCardColumn(
                                'Views',
                                '${analyticsController.analytics?.payload.analytics.totalViews}',
                              ),
                              topPerformingCardColumn(
                                'Taps',
                                '${card?.interactionCount ?? emptyString}',
                              ),
                              topPerformingCardColumn(
                                'Shares',
                                '${analyticsController.analytics?.payload.analytics.totalShares}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
       
        ],
      ),
    );
  }

  Column topPerformingCardColumn(String text, String data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: WonderCardTypography.regularTextTitle2(
            color: AppColors.grayScale500,
            fontSize: 16,
          ),
        ),
        Text(
          data,
          style: WonderCardTypography.boldTextTitle2(
            color: AppColors.grayScale,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
