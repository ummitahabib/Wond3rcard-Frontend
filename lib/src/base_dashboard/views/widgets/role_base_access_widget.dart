import 'package:flutter/material.dart';

class RoleBasedAccessWidget extends StatelessWidget {
  const RoleBasedAccessWidget({
    required this.userRole,
    required this.widgetMap,
    super.key,
  });
  final int userRole;
  final Map<int, Widget> widgetMap;

  @override
  Widget build(BuildContext context) {
    return widgetMap[userRole] ?? const SizedBox();
  }
}
