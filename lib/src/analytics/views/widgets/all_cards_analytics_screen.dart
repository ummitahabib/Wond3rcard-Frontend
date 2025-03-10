import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_wrap/smart_wrap.dart';
import 'package:wond3rcard/src/analytics/data/controller/analytics_controller.dart';
import 'package:wond3rcard/src/analytics/views/widgets/chart_column.dart';
import 'package:wond3rcard/src/analytics/views/widgets/contact_engagement.dart';
import 'package:wond3rcard/src/analytics/views/widgets/geographical_distribution_chart.dart';

// class AllCardsAnalyticsScreen extends HookConsumerWidget {
//   const AllCardsAnalyticsScreen({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final analyticsController = ref.watch(analyticsProvider);

//     useEffect(
//       () {
//         WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//           final analyticsController = ref.read(analyticsProvider);
//           if (analyticsController.analytics == null) {
//             Future.delayed(Duration.zero, () async {
//               await analyticsController.getInteraction();
//             });
//           }
//         });
//         return null;
//       },
//       [],
//     );

//     return SmartWrap(
//       type: WrapType.column,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Expanded(
//           child: Container(
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 //  const Color(
//                 //    0xffEFEFEF,
//                 //  ),
//                 borderRadius: BorderRadius.circular(
//                   15,
//                 ),
//               ),
//               child: const SingleChildScrollView(
//                 physics: BouncingScrollPhysics(),
//                 child: Column(
//                   children: [
//                     ChartColumn(),
//                     ContactEngagement(),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     GeographicalDistributionChart(),
//                     // TopPerformingCard(),
//                   ],
//                 ),
//               )),
//         ),
//       ],
//     );
//   }
// }




class AllCardsAnalyticsScreen extends HookConsumerWidget {
  const AllCardsAnalyticsScreen({super.key});
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

    return SmartWrap(
      type: WrapType.column,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                //  const Color(
                //    0xffEFEFEF,
                //  ),
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: const SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ChartColumn(),
                  //  ContactEngagement(),
                    // SizedBox(
                    //   height: 15,
                    // ),
                //    GeographicalDistributionChart(),
                    // TopPerformingCard(),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
