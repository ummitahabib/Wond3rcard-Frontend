import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';

Future<dynamic> customModalSheet(BuildContext context, Widget child,
    [Color? color]) {
  return showModalBottomSheet(
    backgroundColor: color,
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(SpacingConstants.size20),
        topRight: Radius.circular(SpacingConstants.size20),
      ),
    ),
    builder: (context) => child,
  );
}

Future<dynamic> customDialog(BuildContext context, Widget child,
    [Color? color]) {
  final double paddingValue = MediaQuery.of(context).size.shortestSide;
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: color ?? Theme.of(context).colorScheme.background,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SpacingConstants.size16),
      ),
      content: SizedBox(
        width: paddingValue > size600 ? SpacingConstants.size700 : size510,
        child: child,
      ),
    ),
  );
}

Future<dynamic> customDialogAndModal(
  BuildContext context,
  Widget child, [
  bool isDialog = false,
  Color? color,
]) {
  if (isDesktop(context) || isDialog) {
    return customDialog(context, child, color);
  }
  return customModalSheet(context, child, color);
}
