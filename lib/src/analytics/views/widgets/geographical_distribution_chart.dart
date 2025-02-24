import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';
//import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wond3rcard/src/analytics/data/controller/analytics_controller.dart';
import 'package:wond3rcard/src/analytics/data/model/get_analytics_response.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class GeographicalDistributionChart extends HookConsumerWidget {
  const GeographicalDistributionChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geoData = useState<List<GeoDistributionByCountry>>([]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final analyticsController = ref.read(analyticsProvider);
        if (analyticsController.analytics == null) {
          await analyticsController.getInteraction();
        }
        if (analyticsController.analytics != null) {
          updateGeoData(
            analyticsController.analytics!.payload.analytics.getGeoDistribution
                .geoDistributionByCountry,
            geoData,
          );
        }
      });
      return null;
    }, []);

    return Card(
      color: AppColors.defaultWhite,
      surfaceTintColor: AppColors.defaultWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Geographical Distribution by Country',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            // SizedBox(
            //   height: 200,
            //   child: SfCircularChart(
            //     legend: const Legend(
            //       isVisible: true,
            //       position: LegendPosition.bottom,
            //       overflowMode: LegendItemOverflowMode.wrap,
            //     ),
            //     series: <CircularSeries>[
            //       PieSeries<GeoDistributionByCountry, String>(
            //         dataSource: geoData.value,
            //         xValueMapper: (GeoDistributionByCountry data, _) =>
            //             data.country,
            //         yValueMapper: (GeoDistributionByCountry data, _) =>
            //             int.tryParse(data.percentage.replaceAll('%', '')),
            //         dataLabelMapper: (GeoDistributionByCountry data, _) =>
            //             '${data.country}: ${data.percentage}',
            //         dataLabelSettings: const DataLabelSettings(isVisible: true),
            //         enableTooltip: true,
            //       )
            //     ],
            //   ),
            // ),
        
          ],
        ),
      ),
    );
  }

  void updateGeoData(
    List<GeoDistributionByCountry> geoDistributionByCountry,
    ValueNotifier<List<GeoDistributionByCountry>> geoData,
  ) {
    geoData.value = geoDistributionByCountry;
  }
}
