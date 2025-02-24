

import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

enum AdminRouteMenuItem {
  adminDashBoardDesktopView,
  userManagement,
  cardManagement,
  analytics,
  security,
  subscription,
  flags,
  settings;
 
  String get path {
    switch (this) {
      case AdminRouteMenuItem.adminDashBoardDesktopView:
        return RouteString.adminDashBoardDesktopViewRoute;
      case AdminRouteMenuItem.userManagement:
        return RouteString.userManagement;
      case AdminRouteMenuItem.cardManagement:
        return RouteString.cardManagement;
      case AdminRouteMenuItem.analytics:
        return RouteString.analytics;
      case AdminRouteMenuItem.security:
        return RouteString.security;
      case AdminRouteMenuItem.subscription:
        return RouteString.adminSubscription;
      case AdminRouteMenuItem.flags:
        return RouteString.adminManageFlag;
              case AdminRouteMenuItem.settings:
        return RouteString.adminSettings;
      default:
        return RouteString.notFound;
    }
  }
}
