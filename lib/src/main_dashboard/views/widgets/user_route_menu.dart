import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

enum UserRouteMenu {
  home,
  card,
  share,
  connections,
  analytics,
  profile;

  String get path {
    switch (this) {
      case UserRouteMenu.home:
        return RouteString.home;
      case UserRouteMenu.card:
        return RouteString.cardMain;
      case UserRouteMenu.share:
        return RouteString.shareCardLink;
      case UserRouteMenu.connections:
        return RouteString.connections;
              case UserRouteMenu.analytics:
        return RouteString.analytics;
      case UserRouteMenu.profile:
        return RouteString.profile;
      default:
        return RouteString.notFound;
    }
  }
}
