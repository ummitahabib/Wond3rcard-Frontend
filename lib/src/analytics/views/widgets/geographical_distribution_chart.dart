import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wond3rcard/src/analytics/data/controller/analytics_controller.dart';
import 'package:wond3rcard/src/analytics/data/model/get_analytics_response.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';

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
          const Text(
            'Geographical Distribution by Country',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: SfCircularChart(
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CircularSeries>[
                PieSeries<CountryData, String>(
                  dataSource: chartData,
                  xValueMapper: (CountryData data, _) => data.country,
                  yValueMapper: (CountryData data, _) => data.value,
                  dataLabelMapper: (CountryData data, _) =>
                      '${data.value.toStringAsFixed(1)}%',
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                )
              ],
            ),
          ),
        ],
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

class CountryData {
  final String country;
  final double value;

  CountryData(this.country, this.value);
}

final List<CountryData> chartData = [
  CountryData('US', 30),
  CountryData('UK', 20),
  CountryData('Canada', 10),
  CountryData('Australia', 27),
  CountryData('Germany', 34),
  CountryData('Others', 9),
];
