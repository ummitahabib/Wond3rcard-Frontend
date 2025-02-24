import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/app_responsive.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  final String title;
  List<Widget>? actions;

  CustomAppBar({
    super.key,
    required this.leading,
    required this.title,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppResponsive(
      mobile: AppBar(
        centerTitle: true,
        title: Text(
          title,
        ),
        backgroundColor: Colors.transparent,
        elevation: SpacingConstants.size0,
        leading: leading,
        actions: actions,
      ),
      tablet: AppBar(
        centerTitle: true,
        title: Text(
          title,
        ),
        backgroundColor: Colors.transparent,
        elevation: SpacingConstants.size0,
        leading: leading,
        actions: actions,
      ),
      desktop: AppBar(
        centerTitle: true,
        title: Text(
          title,
        ),
        backgroundColor: Colors.transparent,
        elevation: SpacingConstants.size0,
        leading: leading,
        actions: actions,
      ),
    );
  }
}
