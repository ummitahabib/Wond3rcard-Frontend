
import 'package:flutter/material.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/admin_analytics.dart';
import 'package:wond3rcard/src/utils/util.dart';

class MostViewCardsWidgets extends StatelessWidget {
  const MostViewCardsWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: reusableContainerDeco(),
    child: Column(
      children: [
    Row(
      children: [
        Text('Most Viewed Cards', style: TextStyle(
          fontSize: 16, 
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          color: Color(0xff3A3541),
        ),),
SizedBox(width: 300,),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xffEFEFEF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('This Month top 3', style: TextStyle(
            color: AppColors.primaryShade,
            fontSize: 14, 
            fontWeight: FontWeight.w400,
            
          ),),
        ) , SizedBox(width: 10,),
          Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xffEFEFEF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('All time top 3', style: TextStyle(
            color: AppColors.primaryShade,
            fontSize: 14, 
            fontWeight: FontWeight.w400,
            
          ),),
        ) 
      ],
    )
   , SizedBox(height: 35),
    Divider(color: Colors.red, thickness: 1,)
      ],
    ),
    );
  }
}

