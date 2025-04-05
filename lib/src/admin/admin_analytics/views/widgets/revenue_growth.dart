import 'package:flutter/material.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/admin_analytics.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RevenueGrowthChart extends StatefulWidget {
  const RevenueGrowthChart({super.key});

  @override
  State<RevenueGrowthChart> createState() => _RevenueGrowthChartState();
}

class _RevenueGrowthChartState extends State<RevenueGrowthChart> {
    String _selectedView = 'Default';
  List<_SalesData> data = [];

  @override
  void initState() {
    super.initState();
    _updateChartData();
  }

  void _updateChartData() {
    setState(() {
      if (_selectedView == 'Monthly') {
        data = [
          _SalesData('Jan', 35),
          _SalesData('Feb', 28),
          _SalesData('Mar', 34),
          _SalesData('Apr', 32),
          _SalesData('May', 40),
          _SalesData('Jun', 50),
          _SalesData('Jul', 45),
          _SalesData('Aug', 38),
          _SalesData('Sep', 42),
          _SalesData('Oct', 48),
          _SalesData('Nov', 50),
          _SalesData('Dec', 55),
        ];
      } else if (_selectedView == 'Yearly') {
        data = [
          _SalesData('2020', 200),
          _SalesData('2021', 250),
          _SalesData('2022', 300),
          _SalesData('2023', 350),
          _SalesData('2024', 400),
        ];
      } else {
        data = [
          _SalesData('Jan', 35),
          _SalesData('Feb', 28),
          _SalesData('Mar', 34),
          _SalesData('Apr', 32),
          _SalesData('May', 40),
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
       return        Container(
        padding: EdgeInsets.all(16),
  decoration: reusableContainerDeco(),
       
         child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
               children: [
          DropdownButton<String>(
            value: _selectedView,
            items: ['Default', 'Monthly', 'Yearly']
                .map((String view) => DropdownMenuItem<String>(
                      value: view,
                      child: Text(view),
                    ))
                .toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedView = newValue;
                  _updateChartData();
                });
              }
            },
          ),
          
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Revenue Growth Analysis', alignment: ChartAlignment.near ),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: 'Sales',
                  color: Colors.purple, // Set line color to purple
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                )
              ],
            ),
               
               ],
             ),
       );
 
  }


}



class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

