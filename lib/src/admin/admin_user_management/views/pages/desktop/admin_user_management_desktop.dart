import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/add_user_widget.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/admin_dashboard_user_list_widget.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/dashboard_users_and_recently_joined.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/widgets/recently_created_main_widget.dart';
import 'package:wond3rcard/src/shared/views/widgets/modal_actions.dart';




class AdminUserManagementDesktop extends HookConsumerWidget {
  const AdminUserManagementDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  HeroIcon(
                    HeroIcons.userGroup,
                    color: Color(0xff0F172A),
                    size: 24,
                  ),
                  Text('/  Pages  /  User Management /'),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      customDialog(context, AddUserAccount());
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Color(0xFF6D41CA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          Text(
                            'Add User',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: ManageUserTypeAndRecentlyJoinedWidget()),
                    SizedBox(width: 15,),
                  Expanded(
                    flex: 3,
                    child: RecentlyCreatedMainWidget()),
                ],
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.all(10),
              child: AdminDashboardUserListWidget(),
            )
          ],
        ),
      ),
    );
  }
}
