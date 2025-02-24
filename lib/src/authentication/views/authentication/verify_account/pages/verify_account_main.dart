import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';

class VerifyAccountMain extends HookConsumerWidget {
  const VerifyAccountMain({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppResponsive(
        desktop: Container(), tablet: Container(), mobile: Container());
  }
}
