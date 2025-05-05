
import 'package:wond3rcard/src/main_dashboard/views/widgets/user_route_menu.dart';

class UserNavItem {
  final String title;
  final String icon;
  bool isExpanded;
  final List<UserNavItem>? subItems;
  final UserRouteMenu route;

  UserNavItem({
    required this.title,
    required this.icon,
    this.isExpanded = false,
    this.subItems,
    required this.route,
  });
}
