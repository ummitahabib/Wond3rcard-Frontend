import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/pages/desktop/admin_dashboard_desktop.dart';
import 'package:wond3rcard/src/admin/admin_dashboard/pages/mobile/admin_dashboard_mobile.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class AdminDashBoardScreen extends HookConsumerWidget {
  const AdminDashBoardScreen({super.key, this.child});

  final Widget? child;

  static const routeName = RouteString.adminDashboard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppResponsive(
      desktop: AdminDashBoardDesktop(child: child),
      mobile: AdminDashBoardMobile(),
      tablet: AdminDashBoardDesktop(isTabView: true, child: child),
    );
  }
}
