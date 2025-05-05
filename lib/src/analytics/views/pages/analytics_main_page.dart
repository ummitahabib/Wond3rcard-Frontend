import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/analytics/views/pages/analytics_desktop.dart';
import 'package:wond3rcard/src/analytics/views/pages/analytics_mobile.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';

class AnalyticsMainPage extends ConsumerWidget {
  const AnalyticsMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppResponsive(
      desktop: AnalyticsDesktop(),
      tablet: AnalyticsMobile(),
      mobile: AnalyticsMobile(),
    );
  }
}
