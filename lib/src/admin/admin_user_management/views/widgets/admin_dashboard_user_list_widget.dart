import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/widgets/admin_dashboard_page_header.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/dasboard_user_list_table.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/user_type_filter.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';

class AdminDashboardUserListWidget extends StatelessWidget {
  const AdminDashboardUserListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1230,
      height: 120,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 31),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Users List ',
              style: TextStyle(
                color: AppColors.grayScale,
                fontFamily: 'Barlow',
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: '(1,345)',
                  style: TextStyle(
                    color: AppColors.primaryShade,
                    fontFamily: 'Barlow',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              UserTypeFilter(),
              SizedBox(width: 10),
              Text('3rd January, 2025', style: TextStyle(color: Color(0xff707070))),
              Spacer(),
              ResponsiveSearchTextField(),
              HeroIcon(HeroIcons.document),
            ],
          ),
          SizedBox(height: 18),
          UserListTable(),
        ],
      ),
    );
  }
}














