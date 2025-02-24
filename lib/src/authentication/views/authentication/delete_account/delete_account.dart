import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/authentication/views/authentication/delete_account/views/pages/desktop/delete_account_desktop.dart';
import 'package:wond3rcard/src/authentication/views/authentication/delete_account/views/pages/mobile/delete_account_mobile.dart';
import 'package:wond3rcard/src/authentication/views/authentication/delete_account/views/pages/tablet/delete_account_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class DeleteAccountMain extends HookConsumerWidget {
  const DeleteAccountMain({
    super.key,
  });

  static const routeName = RouteString.deleteAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppResponsive(
      desktop: DeleteAccountDesktop(),
      tablet: DeleteAccountTablet(),
      mobile: DeleteAccountMobile(),
    );
  }
}
