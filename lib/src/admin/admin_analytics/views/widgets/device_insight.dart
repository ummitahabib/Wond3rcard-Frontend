import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class DeviceInsight extends StatelessWidget {
  const DeviceInsight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
        color: AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Device Insight',
            style: WonderCardTypography.boldTextTitleBold(
                color: Color(0xff3A3541)),
          ),
          SizedBox(
            height: 15,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: deviceInsightList.length,
            itemBuilder: (context, index) {
              return DeviceInsightWidget(user: deviceInsightList[index]);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text('Traffic Source'),
          TrafficSourceWidget(),
        ],
      ),
    );
  }
}

class DeviceInsightWidget extends StatelessWidget {
  final DeviceInsightDataModel user;

  const DeviceInsightWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SvgPicture.asset(
                    user.imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Text(
                user.deviceType,
                style: WonderCardTypography.boldTextTitleBold(
                  color: AppColors.grayScale700,
                ),
              ),
              Spacer(),
              Text(
                user.data,
                style: TextStyle(
                  color: AppColors.grayScale600,
                  fontFamily: 'Barlow',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class DeviceInsightDataModel {
  final String deviceType;
  final String imageUrl;
  final String data;

  DeviceInsightDataModel({
    required this.deviceType,
    required this.imageUrl,
    required this.data,
  });
}

final List<DeviceInsightDataModel> deviceInsightList = [
  DeviceInsightDataModel(
    deviceType: "Mobile",
    imageUrl: SvgAssets.mobile,
    data: "96.42%",
  ),
  DeviceInsightDataModel(
    deviceType: "Desktop",
    imageUrl: SvgAssets.desktop,
    data: "2.76%",
  ),
  DeviceInsightDataModel(
    deviceType: "Tablet",
    imageUrl: SvgAssets.tablet,
    data: "0.82%",
  ),
];

class DataTrafficSource {
  final String name;
  final double percentage;

  DataTrafficSource({required this.name, required this.percentage});
}

class TrafficSourceWidget extends StatelessWidget {
  const TrafficSourceWidget({super.key});

  List<DataTrafficSource> get trafficSources => [
        DataTrafficSource(name: 'QR Code', percentage: 20),
        DataTrafficSource(name: 'Email', percentage: 30),
        DataTrafficSource(name: 'Social', percentage: 80),
      ];

  Color getDynamicColor(double percentage) {
    int alpha = (255 * (percentage / 100)).toInt();
    return Colors.purple.withAlpha(alpha);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: trafficSources.map((source) {
        return Container(
          padding: EdgeInsets.all(24),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: getDynamicColor(source.percentage),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '${source.name}\n${source.percentage}%',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }
}
