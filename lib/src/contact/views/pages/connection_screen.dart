import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/contact/views/pages/desktop/connection_desktop.dart';
import 'package:wond3rcard/src/contact/views/pages/mobile/connection_mobile.dart';
import 'package:wond3rcard/src/utils/util.dart';



class ConnectionMain extends HookConsumerWidget {
  const ConnectionMain({super.key});

  static const routeName = RouteString.home;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: ConnectionDesktop(),
      tablet: ConnectionMobile(),
      mobile: ConnectionMobile(),
    );
  }
}








