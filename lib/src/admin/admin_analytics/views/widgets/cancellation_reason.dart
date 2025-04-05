import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CancellationPieChart extends StatelessWidget {
  final List<CancellationReason> data;

  CancellationPieChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
        padding: const EdgeInsets.all(16.0),
        child: SfCircularChart(
          title: ChartTitle(text: 'Subscription Cancellation Reasons'),
          legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <PieSeries<CancellationReason, String>>[
            PieSeries<CancellationReason, String>(
              dataSource: data,
              xValueMapper: (CancellationReason reason, _) => reason.reason,
              yValueMapper: (CancellationReason reason, _) => reason.percentage,
              pointColorMapper: (CancellationReason reason, _) => reason.color,
              dataLabelMapper: (CancellationReason reason, _) =>
                  '${reason.reason}: ${reason.percentage.toStringAsFixed(0)}%',
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      
    );
  }
}


class CancellationReason {
  final String reason;
  final double percentage;
  final Color color;

  CancellationReason({
    required this.reason,
    required this.percentage,
    required this.color,
  });
}


final List<CancellationReason> cancellationData = [
  CancellationReason(reason: 'High Pricing', percentage: 35, color: Color(0xFF5368F0)),
  CancellationReason(reason: 'Customer Support Issues', percentage: 25, color: Color(0xFF9D57D5)),
  CancellationReason(reason: 'Lack of Features', percentage: 20, color: Color(0xFFFEAB00)),
  CancellationReason(reason: 'Others', percentage: 20, color: Color(0xFFFF3131)),
];
