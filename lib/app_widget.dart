import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/app_router_desktop.dart';
import 'package:wond3rcard/src/utils/app_router_mobile.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
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
