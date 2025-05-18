import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/data/model/analytics_card_data_model.dart';
import 'package:wond3rcard/src/analytics/data/model/chart_column_data.dart';
import 'package:wond3rcard/src/analytics/data/model/get_analytics_response.dart';
import 'package:wond3rcard/src/utils/ui_data.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wond3rcard/src/analytics/data/controller/analytics_controller.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class ChartColumn extends HookConsumerWidget {
  const ChartColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsController = ref.watch(analyticsProvider);
    final chartData = useState<List<ChartColumnData>>([]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final analyticsController = ref.read(analyticsProvider);
        if (analyticsController.analyticsModel.isEmpty) {
          await analyticsController.getInteraction();
        } else {
          updateChartData(analyticsController.analytics!, chartData);
        }
      });
      return null;
    }, []);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 175 / 166,
        ),
        itemCount: cardDataList.length,
        itemBuilder: (context, index) {
          final cardData = cardDataList[index];
          return buildCard(context, analyticsController, chartData, cardData);
        },
      ),
    );
  }

  Widget buildCard(
    BuildContext context,
    AnalyticsNotifier analyticsController,
    ValueNotifier<List<ChartColumnData>> chartData,
    CardDataModel cardData,
  ) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 175,
      height: 166,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.defaultWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardData.title,
                style: WonderCardTypography.boldTextTitle2(
                  color: AppColors.grayScale700,
                  fontName: 'Barlow',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              HeroIcon(cardData.icon, size: 20, color: cardData.iconColor),
            ],
          ),
          const SizedBox(height: 12),
          analyticsController.analytics == null
              ? _emptyAnalyticsInnerWidget()
              : _analyticsInnerWidget(analyticsController),
        ],
      ),
    );
  }



  Column _emptyAnalyticsInnerWidget() {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('0',
                    style: WonderCardTypography.boldTextH5(
                      fontSize: 23,
                      color: AppColors.grayScale,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    children: [
                      const HeroIcon(
                        HeroIcons.arrowTrendingUp,
                        color: AppColors.green,
                        size: 24,
                      ),
                      Text(
                        '0% vs last month',
                        style: const TextStyle(
                          color: AppColors.success,
                          fontFamily: 'Barlow',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              );
  }
  Column _analyticsInnerWidget(AnalyticsNotifier analyticsController) {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( 
                  analyticsController
                        .analytics!.payload.analytics.comparison.views.current
                        .toString(),
                    style: WonderCardTypography.boldTextH5(
                      fontSize: 23,
                      color: AppColors.grayScale,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    children: [
                      const HeroIcon(
                        HeroIcons.arrowTrendingUp,
                        color: AppColors.green,
                        size: 24,
                      ),
                      Text(
                        '${analyticsController.analytics!.payload.analytics.comparison.views.difference}% vs last month',
                        style: const TextStyle(
                          color: AppColors.success,
                          fontFamily: 'Barlow',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              );
  }

  void updateChartData(
    AnalyticsResponse analytics,
    ValueNotifier<List<ChartColumnData>> chartData,
  ) {
    final data = <ChartColumnData>[];
    final months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    final currentMonthIndex = DateTime.now().month - 1;
    final lastMonthIndex = currentMonthIndex - 1;

    for (var i = 0; i < months.length; i++) {
      data.add(
        ChartColumnData(
          x: months[i],
          y: i == lastMonthIndex
              ? analytics.payload.analytics.comparison.views.lastMonth
                  .toDouble()
              : null,
          y1: i == currentMonthIndex
              ? analytics.payload.analytics.comparison.views.current.toDouble()
              : null,
        ),
      );
    }
    chartData.value = data;
  }
}
