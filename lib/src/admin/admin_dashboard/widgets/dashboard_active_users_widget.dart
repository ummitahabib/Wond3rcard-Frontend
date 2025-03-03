import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/user_type_container.dart';
import 'package:wond3rcard/src/utils/assets.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class DashbaordActiveUsersWidget extends StatelessWidget {
  const DashbaordActiveUsersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 812,
      height: 572,
      decoration: BoxDecoration(
        color: AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active users right now',
            style: WonderCardTypography.boldTextTitleBold(
                color: Color(0xff3A3541)),
          ),
          SizedBox(
            height: size20,
          ),
          SingleChildScrollView(
            child: Row(
              children: [
                AdminDashboardReusableCard(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 27,
                            height: 27,
                            child: SvgPicture.asset(SvgAssets.users),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Users',
                            style: TextStyle(
                              color: Color(0xff3A3541),
                              fontFamily: 'Barlow',
                              fontSize: 14.522,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Text(
                          '${(totalUsers / 1000).toStringAsFixed(1)}k',
                          style: TextStyle(
                            color: Color(0xff3A3541),
                            fontFamily: 'Barlow',
                            fontSize: 43.566,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                AdminDashboardReusableCard(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 27,
                            height: 27,
                            child: SvgPicture.asset(SvgAssets.clicks),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Clicks',
                            style: TextStyle(
                              color: Color(0xff3A3541),
                              fontFamily: 'Barlow',
                              fontSize: 14.522,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Text(
                          '1m',
                          style: TextStyle(
                            color: Color(0xff3A3541),
                            fontFamily: 'Barlow',
                            fontSize: 43.566,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                AdminDashboardReusableCard(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 27,
                            height: 27,
                            child: SvgPicture.asset(SvgAssets.clicks),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Items',
                            style: TextStyle(
                              color: Color(0xff3A3541),
                              fontFamily: 'Barlow',
                              fontSize: 14.522,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Text(
                          '68K',
                          style: TextStyle(
                            color: Color(0xff3A3541),
                            fontFamily: 'Barlow',
                            fontSize: 43.566,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                AdminDashboardReusableCard(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 27,
                            height: 27,
                            child: SvgPicture.asset(SvgAssets.sales),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Sales',
                            style: TextStyle(
                              color: Color(0xff3A3541),
                              fontFamily: 'Barlow',
                              fontSize: 14.522,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Text(
                          '345',
                          style: TextStyle(
                            color: Color(0xff3A3541),
                            fontFamily: 'Barlow',
                            fontSize: 43.566,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final List<DashboardUsers> dashboardUsersList = [
  DashboardUsers(
      userType: "Basic Users", iconPath: SvgAssets.users, count: 5200),
  DashboardUsers(
      userType: "Organizations", iconPath: SvgAssets.users, count: 3400),
  DashboardUsers(
      userType: "Premium Users", iconPath: SvgAssets.users, count: 3600),
];

final int totalUsers =
    dashboardUsersList.fold(0, (sum, user) => sum + user.count);

class DashboardUsers {
  final String userType;
  final String iconPath;
  final int count;

  DashboardUsers(
      {required this.userType, required this.iconPath, required this.count});
}
