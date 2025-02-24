import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wond3rcard/src/analytics/data/controller/analytics_controller.dart';
import 'package:wond3rcard/src/analytics/data/model/get_analytics_response.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class RadialChartBar extends HookConsumerWidget {
  const RadialChartBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, Color> labels = {
      'Qr Code': const Color(0xff3a0ca3),
      'Email': const Color(0xffb5179e),
      'Social Links': const Color(0xffffc300),
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
          updateTrafficData(
            analyticsController.analytics!,
            trafficData,
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
            // Row(
            //   children: [
            //     Expanded(
            //       child: SizedBox(
            //         height: 200,
            //         child: SfRadialGauge(
            //           axes: [
            //             RadialAxis(
            //               labelOffset: 0,
            //               pointers: trafficData.value.entries.map((entry) {
            //                 final index =
            //                     labels.keys.toList().indexOf(entry.key);
            //                 return RangePointer(
            //                   value: entry.value,
            //                   cornerStyle: CornerStyle.bothCurve,
            //                   color: labels.values.elementAt(index),
            //                   width: 30,
            //                 );
            //               }).toList(),
            //               axisLineStyle: const AxisLineStyle(thickness: 30),
            //               startAngle: 130,
            //               endAngle: 130,
            //               showLabels: false,
            //               showTicks: false,
            //               annotations: [
            //                 GaugeAnnotation(
            //                   widget: Column(
            //                     children: [
            //                       Text(
            //                         '${getTotalTraffic(trafficData.value)}%',
            //                         style: const TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 26,
            //                             color: Colors.grey),
            //                       ),
            //                       const Text(
            //                         'Traffic this year',
            //                         style: TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 14,
            //                             color: Colors.grey),
            //                       ),
            //                     ],
            //                   ),
            //                   positionFactor: 0.2,
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: List<Widget>.generate(
            //         labels.length,
            //         (index) => buildLabelsChart(labels.keys.elementAt(index),
            //             labels.values.elementAt(index)),
            //       ),
            //     ),
            //   ],
            // ),
        
        
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabelsChart(String label, Color color) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(label),
      ],
    );
  }

  void updateTrafficData(AnalyticsResponse trafficSource,
      ValueNotifier<Map<String, double>> trafficData) {
    trafficData.value = {
      'Qr Code': trafficSource.payload.analytics.totalQRCode.toDouble(),
      'Email': trafficSource.payload.analytics.totalEmail.toDouble(),
      'Social Links':
          trafficSource.payload.analytics.totalSocialLink.toDouble(),
    };
  }

  double getTotalTraffic(Map<String, double> trafficData) {
    return trafficData.values.reduce((sum, element) => sum + element);
  }
}

// class RadialChatBar extends HookConsumerWidget {
//   const RadialChatBar({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final Map<String, Color> Labels = {
//       'Qr Code': const Color(0xff3a0ca3),
//       'Email': const Color(0xffb5179e),
//       'Social Links': const Color(0xffffc300),
//     };

//     return Card(
//         color: AppColors.defaultWhite,
//         surfaceTintColor: AppColors.defaultWhite,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 200,
//                       child: SfRadialGauge(axes: [
//                         RadialAxis(
//                           labelOffset: 0,
//                           pointers: const [
//                             RangePointer(
//                                 value: 20,
//                                 cornerStyle: CornerStyle.bothCurve,
//                                 color: Color(0xffb5179e),
//                                 width: 30)
//                           ],
//                           axisLineStyle: const AxisLineStyle(thickness: 30),
//                           startAngle: 130,
//                           endAngle: 130,
//                           showLabels: false,
//                           showTicks: false,
//                           annotations: const [
//                             GaugeAnnotation(
//                               widget: Column(
//                                 children: [
//                                   Text(
//                                     '77%',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 26,
//                                         color: Colors.grey),
//                                   ),
//                                   Text(
//                                     'Visitors this year',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 26,
//                                         color: Colors.grey),
//                                   ),
//                                 ],
//                               ),
//                               positionFactor: 0.2,
//                             ),
//                           ],
//                         ),
//                         RadialAxis(
//                           pointers: const [
//                             RangePointer(
//                               value: 20,
//                               cornerStyle: CornerStyle.bothCurve,
//                               color: Color(0xff3a0ca3),
//                               width: 30,
//                             )
//                           ],
//                           startAngle: 10,
//                           endAngle: 10,
//                           showLabels: false,
//                           showTicks: false,
//                           showAxisLine: false,
//                         ),
//                         RadialAxis(
//                           pointers: const [
//                             RangePointer(
//                               value: 20,
//                               cornerStyle: CornerStyle.bothCurve,
//                               color: Color(0xfff72585),
//                               width: 30,
//                             )
//                           ],
//                           startAngle: 90,
//                           endAngle: 90,
//                           showLabels: false,
//                           showTicks: false,
//                           showAxisLine: false,
//                         ),
//                         RadialAxis(
//                           pointers: const [
//                             RangePointer(
//                               value: 20,
//                               cornerStyle: CornerStyle.bothCurve,
//                               color: Color(0xffffc300),
//                               width: 30,
//                             )
//                           ],
//                           startAngle: 40,
//                           endAngle: 40,
//                           showLabels: false,
//                           showTicks: false,
//                           showAxisLine: false,
//                         ),
//                       ]),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: List<Widget>.generate(
//                       4,
//                       (index) => LabelsChart(Labels.keys.elementAt(index),
//                           Labels.values.elementAt(index)),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         ));
//   }

//   LabelsChart(String label, Color color) {
//     return Row(
//       children: [
//         Container(
//           height: 15,
//           width: 15,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(5),
//           ),
//         ),
//         const SizedBox(
//           width: 5,
//         ),
//         Text(label)
//       ],
//     );
//   }
// }
