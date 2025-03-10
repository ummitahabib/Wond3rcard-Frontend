import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/widgets/dashboard_active_users_widget.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/widgets/device_category.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/widgets/earning_widgets.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/widgets/top_countries_widget.dart';
import 'package:wond3rcard/src/admin/admin_user_management/data/controller/admin_user_management_controller.dart';

class AdminDashboardDesktopView extends HookConsumerWidget {
  const AdminDashboardDesktopView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;


        useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final adminUserController = ref.read(andminUserManagementProvider);
         
            Future.delayed(Duration.zero, () async {
              await adminUserController.getAllUsers();
            });
          
        });
        return null;
      },
      [],
    );

    
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
                    HeroIcons.homeModern,
                    color: Color(0xff0F172A),
                    size: 24,
                  ),
                  Text('/  Pages  /  Dashboard /'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                         mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                             DashbaordActiveUsersWidget(),
                          SizedBox(
                            height:size.height * 0.02,
                          ),
                          DashbaordActiveUsersWidget(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          EarningWidgets(),
                          SizedBox(
                                 height:size.height * 0.02,
                          ),
                          DeviceCategory(),
                          SizedBox(
                                  height:size.height * 0.02,
                          ),
                          TopCountries(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
