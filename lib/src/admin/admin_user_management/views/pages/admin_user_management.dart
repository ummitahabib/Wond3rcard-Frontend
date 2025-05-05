import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/pages/desktop/admin_user_management_desktop.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/pages/mobile/admin_user_management_mobile.dart';
import 'package:wond3rcard/src/admin/admin_user_management/views/pages/tablet/admin_user_management_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';

class AdminUserManagement extends HookConsumerWidget {
  const AdminUserManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppResponsive(
        desktop: AdminUserManagementDesktop(),
        tablet: AdminUserManagementTablet(),
        mobile: AdminUserManagementMobile());
  }
}
