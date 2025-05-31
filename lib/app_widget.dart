import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/app_router_desktop.dart';
import 'package:wond3rcard/src/utils/app_router_mobile.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();

    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  Future<void> initDeepLinks() async {
    // Handle links
    _linkSubscription = AppLinks().uriLinkStream.listen((uri) {
      debugPrint('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    routerMobile.go(uri.fragment);
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 950) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: routerDesktop,
          );
        } else if (constraints.maxWidth >= 600) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: routerMobile,
          );
        } else if (constraints.maxWidth >= 300) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: routerMobile,
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: Text("Screen size not supported")),
            ),
          );
        }
      },
    );
  }
}
