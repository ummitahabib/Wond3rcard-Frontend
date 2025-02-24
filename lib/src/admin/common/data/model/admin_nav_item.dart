import 'package:wond3rcard/src/admin/common/widgets/admin_route_menu_item.dart';

class AdminNavItem {
  final String title;
  final String icon;
  bool isExpanded;
  final List<AdminNavItem>? subItems;
  final AdminRouteMenuItem route;

  AdminNavItem({
    required this.title,
    required this.icon,
    this.isExpanded = false,
    this.subItems,
    required this.route,
  });
}
