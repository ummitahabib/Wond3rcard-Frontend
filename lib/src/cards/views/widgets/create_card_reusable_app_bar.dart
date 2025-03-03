import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

class CreateCardReusableAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  CreateCardReusableAppBar(
      {super.key, this.route, this.titleText, this.actions, this.leading});

  String? route;
  String? titleText;
  List<Widget>? actions;
  Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: leading ?? _buildBackButton(context, route),
      title: Text(
          textAlign: TextAlign.center,
          titleText ?? 'Create Account',
          style: WonderCardTypography.boldTextH5(
              fontSize: 23, color: AppColors.grayScale)),
      actions: actions ?? [_buildSaveButton()],
    );
  }

  Widget _buildBackButton(BuildContext context, String? route) {
    return IconButton(
      onPressed: () => context.go(route ?? '/'),
      icon: const HeroIcon(HeroIcons.arrowLeft),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 90,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.defaultWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Save',
            style: WonderCardTypography.boldTextTitle2(
              fontSize: 16,
              color: AppColors.grayScale,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
