import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/views/widgets/analytics_ui_widgets.dart';
import 'package:wond3rcard/src/contact/data/controller/contact_controller.dart';
import 'package:wond3rcard/src/contact/views/pages/connection_list.dart';
import 'package:wond3rcard/src/contact/views/pages/contacts_page.dart';
import 'package:wond3rcard/src/contact/views/pages/desktop/connection_desktop.dart';
import 'package:wond3rcard/src/contact/views/pages/mobile/connection_mobile.dart';
import 'package:wond3rcard/src/contact/views/pages/mobile/contact_mobile.dart';
import 'package:wond3rcard/src/profile/data/profile_controller/profile_controller.dart';
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








