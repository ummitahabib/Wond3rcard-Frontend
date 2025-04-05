import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SubscriptionData {
  final String month;
  final int premium;
  final int business;

  SubscriptionData({required this.month, required this.premium, required this.business});
}

final List<SubscriptionData> mockData = [
  SubscriptionData(month: 'January', premium: 120, business: 80),
  SubscriptionData(month: 'February', premium: 140, business: 100),
  SubscriptionData(month: 'March', premium: 160, business: 110),
  SubscriptionData(month: 'April', premium: 180, business: 120),
  SubscriptionData(month: 'May', premium: 200, business: 130),
  SubscriptionData(month: 'June', premium: 220, business: 150),
];




class SubscriptionChart extends StatefulWidget {
  @override
  _SubscriptionChartState createState() => _SubscriptionChartState();
}

class _SubscriptionChartState extends State<SubscriptionChart> {
  late List<SubscriptionData> _allData;
  String _selectedMonth = 'January';

  @override
  void initState() {
    super.initState();
    _allData = mockData;
  }

  List<String> get _availableMonths => _allData.map((e) => e.month).toList();

  @override
  Widget build(BuildContext context) {
    final currentData = _allData.where((data) => data.month == _selectedMonth).toList();

    return 
       Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedMonth,
              onChanged: (value) {
                setState(() {
                  _selectedMonth = value!;
                });
              },
              items: _availableMonths.map((String month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Subscription Growth'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries>[
                ColumnSeries<SubscriptionData, String>(
                  dataSource: currentData,
                  xValueMapper: (SubscriptionData data, _) => data.month,
                  yValueMapper: (SubscriptionData data, _) => data.premium,
                  name: 'Premium Plan',
                  color: Colors.blue,
                ),
                ColumnSeries<SubscriptionData, String>(
                  dataSource: currentData,
                  xValueMapper: (SubscriptionData data, _) => data.month,
                  yValueMapper: (SubscriptionData data, _) => data.business,
                  name: 'Business Plan',
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
   
    );
  }
}
