import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/preview_card/views/pages/desktop/preview_card_desktop.dart';
import 'package:wond3rcard/src/preview_card/views/pages/mobile/preview_card_mobile.dart';
import 'package:wond3rcard/src/preview_card/views/pages/tablet/preview_card_tablet.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

class PreviewCardMainScreen extends HookConsumerWidget {
  const PreviewCardMainScreen({super.key});

  static const routeName = RouteString.previewCard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  AppResponsive(
      desktop: PreviewCardScreenDesktop(),
      mobile: PreviewCardScreenMobile(),
      tablet: PreviewCardScreenTablet(),
    );
  }
}
