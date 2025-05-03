import 'package:flutter/material.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/admin_analytics.dart';
import 'package:wond3rcard/src/utils/util.dart';

class CardStatsTable extends StatelessWidget {
  final List<CardStats> stats;

  CardStatsTable({required this.stats});

  @override
  Widget build(BuildContext context) {
    return 
       Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
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
            
             DataTable(
               columnSpacing: 24,
               headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
               columns: const [
                 DataColumn(label: Text('Rank')),
                 DataColumn(label: Text('Card Name')),
                 DataColumn(label: Text('Total Views')),
                 DataColumn(label: Text('Clicks')),
               ],
               rows: stats.map((stat) {
                 return DataRow(cells: [
                   DataCell(Text(stat.rank.toString())),
                   DataCell(Text(stat.cardName)),
                   DataCell(Text(stat.totalViews.toString())),
                   DataCell(Text(stat.clicks.toString())),
                 ]);
               }).toList(),
             ),
           ],
         ),
       );
  }
}


class CardStats {
  final int rank;
  final String cardName;
  final int totalViews;
  final int clicks;

  CardStats({
    required this.rank,
    required this.cardName,
    required this.totalViews,
    required this.clicks,
  });
}


final List<CardStats> cardStatsList = [
  CardStats(rank: 1, cardName: 'Admin Users Card', totalViews: 500, clicks: 321),
  CardStats(rank: 2, cardName: 'Business Overview Card', totalViews: 430, clicks: 288),
  CardStats(rank: 3, cardName: 'Premium Stats Card', totalViews: 390, clicks: 245),
];
