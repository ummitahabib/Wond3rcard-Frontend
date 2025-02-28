import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wond3rcard/src/shared/views/widgets/wonder_card_design_system/back_navigator.dart';
import 'package:wond3rcard/src/utils/util.dart';

AppBar cardLayoutAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    leading: BackNavigator(
      onPress: () => context.go(RouteString.mainDashboard),
    ),
    title: Text(
      'Create card',
      style: WonderCardTypography.boldTextH5(
        fontSize: 23,
        color: AppColors.grayScale,
      ),
    ),
    actions: [
      Container(
        margin: const EdgeInsets.all(10),
        width: 90,
        height: 40,
        decoration: BoxDecoration(
            color: AppColors.defaultWhite,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          'save',
          style: WonderCardTypography.boldTextTitle2(),
        )),
      )
    ],
  );
}
