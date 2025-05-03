import 'package:flutter/material.dart';
import 'package:wond3rcard/src/admin/admin_analytics/views/admin_analytics.dart';
import 'package:wond3rcard/src/utils/util.dart';
class SystemActivityLogWidget extends StatelessWidget {
  const SystemActivityLogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: reusableContainerDeco(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'System Activity Logs',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Lato',
                  color: Color(0xff3A3541),
                ),
              ),
              SizedBox(width: 200),
              Text(
                'View More',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lato',
                  color: Color(0xff3A3541),
                ),
              ),
              SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
                child: Center(
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              )
            ],
          ),
          Divider(
            color: Color.fromARGB(255, 127, 127, 156),
            thickness: 1,
          ),
          SizedBox(height: 30),
          _systemActivityLogList(),
        ],
      ),
    );
  }

  Widget _systemActivityLogList() {
    return Column(
           crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
      children:
          systemActivityLogs.map((log) => _systemActivityLogItem(log)).toList(),
    );
  }

  Widget _systemActivityLogItem(SystemActivityLogModel log) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _columnItem('Time Stamp', log.timeStamp),
          SizedBox(width: 100),
          _columnItem('Action Type', log.actionType),
             SizedBox(width: 100),
          _columnItem('Priority', log.priority),
        ],
      ),
    );
  }

  Widget _columnItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _reusableHeader(text: title),
        SizedBox(height: 4),
        _reusableText(text: value),
      ],
    );
  }

  Text _reusableText({String? text}) {
    return Text(
      text ?? '',
      style: WonderCardTypography.boldTextTitle2(
        color: Color(0xff9E9E9E),
        fontSize: 16,
      ),
    );
  }

  Text _reusableHeader({String? text}) {
    return Text(
      text ?? '',
      style: WonderCardTypography.boldTextTitleBold(
        color: Color(0xff3A3541),
        fontSize: 16,
      ),
    );
  }
}

class SystemActivityLogModel {
  final String timeStamp;
  final String actionType;
  final String priority;

  SystemActivityLogModel({
    required this.timeStamp,
    required this.actionType,
    required this.priority,
  });
}

final List<SystemActivityLogModel> systemActivityLogs = [
  SystemActivityLogModel(timeStamp: '5 min ago', actionType: 'Security Alert', priority: 'High'),
  SystemActivityLogModel(timeStamp: '3 min ago', actionType: 'Failure Payment', priority: 'Low'),
  SystemActivityLogModel(timeStamp: '10 min ago', actionType: 'Failure Payment', priority: 'Moderate'),
  SystemActivityLogModel(timeStamp: '4 days ago', actionType: 'Subscrip Upgrade', priority: 'Low'),
  SystemActivityLogModel(timeStamp: '2 days ago', actionType: 'Security Alert', priority: 'High'),
];
