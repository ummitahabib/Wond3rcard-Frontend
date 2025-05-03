  import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/util.dart';

Row reuseableHeaderWidget({
  String? number, 
  String? text,
  Color? activeColor,
  }) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 30, height: 30, decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: activeColor ?? AppColors.primaryShade,
                ),
                child: Center(child: Text(number ?? emptyString, style: WonderCardTypography.titleH6(
                  color: Colors.white, fontSize: 18
                ),)),
                ),
                SizedBox(width: 15,),
                Text(text ?? emptyString, style: WonderCardTypography.headlineH3(
                  color: activeColor ?? AppColors.primaryShade, 
                ))
              ],
            );
  }
