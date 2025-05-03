import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/utils/util.dart';

class AverageViewDuration extends ConsumerWidget {
  const AverageViewDuration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
       padding: EdgeInsets.all(10),
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
              Text('Average view duration', style: WonderCardTypography.boldTextTitleBold(
                color:Colors.black , fontSize: 18,
              )),
              SizedBox(height: 20,),

 Text('2:16', style: WonderCardTypography.boldTextH3(
                color:Colors.black , fontSize: 33,
              )),
              SizedBox(height: 15,),
 Text('Minutes per view', style: WonderCardTypography.boldTextTitle2(
                color: Color(0xff424242) , fontSize: 16,
              )),
              
            ],
          ),
    );
  }
}