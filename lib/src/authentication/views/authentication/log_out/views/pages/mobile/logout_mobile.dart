import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/button/wonder_card_button.dart';

class LogoutMobile extends HookConsumerWidget {
  const LogoutMobile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WonderCardButton(
      text: 'logout',
      onPressed: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.clear();
      },
    );
  }
}
