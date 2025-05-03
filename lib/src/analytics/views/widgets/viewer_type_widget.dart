import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/utils/util.dart';

class ViewerTypeWidget extends ConsumerWidget {
  const ViewerTypeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
         padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.defaultWhite,
            borderRadius: BorderRadius.circular(12),),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
            Text('Viewers type', style: WonderCardTypography.boldTextTitleBold(),),
            SizedBox(height: 8),
Column(
      children: viewerTypes.map((viewerType) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ViewerTypeBar(viewType: viewerType),
        );
      }).toList(),
    ),
              ],
            ),
    );
  }
}





class ViewerType {
  final String label;
  final double percentage; // should be from 0 to 100
  final Color color;

  ViewerType({
    required this.label,
    required this.percentage,
    required this.color,
  });
}


final List<ViewerType> viewerTypes = [
  ViewerType(label: 'Registered', percentage: 65.0, color: Color(0xFF402577)),
  ViewerType(label: 'Non-Registered', percentage: 35.0, color: Color(0xFFBDBDBD)),
];


class ViewerTypeBar extends StatelessWidget {
  final ViewerType viewType;

  const ViewerTypeBar({super.key, required this.viewType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${viewType.label} (${viewType.percentage.toStringAsFixed(0)}%)',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        Stack(
          children: [
            Container(
              width: 520,
              height: 8.33,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7.5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              child: Container(
                width: 520 * (viewType.percentage / 100),
                height: 8.33,
                decoration: BoxDecoration(
                  color: viewType.color,
                  borderRadius: BorderRadius.circular(7.5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
