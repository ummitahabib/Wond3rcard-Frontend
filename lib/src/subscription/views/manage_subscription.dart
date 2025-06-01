import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/profile/views/pages/desktop/manage_subscription_desktop.dart';
import 'package:wond3rcard/src/subscription/views/widgets/plan_section.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class ManageSubscriptionMainScreen extends HookConsumerWidget {
  const ManageSubscriptionMainScreen({super.key});

  static const routeName = RouteString.manageUserSubscription;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppResponsive(
      desktop: ManageSubscriptionDesktop(),
      mobile: PlanSection(),
      //ManageSubscriptionMobile(),
      tablet: Container(),
      //ManageSubscriptionMobile(),
    );
  }
}
