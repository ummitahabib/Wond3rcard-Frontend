import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/views/authentication/login/views/pages/mobile/login_mobile.dart';

class LoginDesktop extends HookConsumerWidget {
  const LoginDesktop({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoginMobile();
  }
}
