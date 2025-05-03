import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/data/controller/analytics_controller.dart';
import 'package:wond3rcard/src/analytics/data/model/get_analytics_response.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadialChartBar extends HookConsumerWidget {
  const RadialChartBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, Color> labelColors = {
      'Qr Code': Color(0xffFACC15),
      'Email': Color(0xff6D41CA),
      'Social Links': Color(0xff03A526),
    };

    final trafficData = useState<Map<String, double>>({
      'Qr Code': 0,
      'Email': 0,
      'Social Links': 0,
    });

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final analyticsController = ref.read(analyticsProvider);
        if (analyticsController.analytics == null) {
          await analyticsController.getInteraction();
        }
        if (analyticsController.analytics != null) {
          updateTrafficData(analyticsController.analytics!, trafficData);
        }
      });
      return null;
    }, []);

    final totalTraffic = getTotalTraffic(trafficData.value);

    final List<_ChartData> chartData = trafficData.value.entries.map(
      (entry) {
        return _ChartData(
          entry.key,
          entry.value,
          labelColors[entry.key]!,
        );
      },
    ).toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SfCircularChart(
            title: ChartTitle(
              alignment: ChartAlignment.near,
              text: 'Traffic this year (${totalTraffic.toStringAsFixed(0)}%)',
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            legend: Legend(
              isVisible: true,
              position: LegendPosition.right,
              overflowMode: LegendItemOverflowMode.wrap,
              iconHeight: 10,
              iconWidth: 10,
            ),
            series: <RadialBarSeries<_ChartData, String>>[
              RadialBarSeries<_ChartData, String>(
                dataSource: chartData,
                xValueMapper: (_ChartData data, _) => data.label,
                yValueMapper: (_ChartData data, _) => data.value,
                pointColorMapper: (_ChartData data, _) => data.color,
                dataLabelMapper: (_ChartData data, _) =>
                    '${data.value.toStringAsFixed(0)}%',
                maximumValue: 100,
                radius: '100%',
                innerRadius: '30%',
                gap: '8%',
                cornerStyle: CornerStyle.bothCurve,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updateTrafficData(
    AnalyticsResponse trafficSource,
    ValueNotifier<Map<String, double>> trafficData,
  ) {
    trafficData.value = {
      'Qr Code': trafficSource.payload.analytics.totalQRCode.toDouble(),
      'Email': trafficSource.payload.analytics.totalEmail.toDouble(),
      'Social Links':
          trafficSource.payload.analytics.totalSocialLink.toDouble(),
    };
  }

  double getTotalTraffic(Map<String, double> trafficData) {
    return trafficData.values.fold(0, (sum, value) => sum + value);
  }
}

class _ChartData {
  final String label;
  final double value;
  final Color color;

  _ChartData(this.label, this.value, this.color);
}
