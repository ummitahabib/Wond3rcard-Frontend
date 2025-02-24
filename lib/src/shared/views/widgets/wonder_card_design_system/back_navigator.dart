import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
class BackNavigator extends StatelessWidget {
  const BackNavigator({super.key, this.onPress});

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: HeroIcon(
        HeroIcons.chevronLeft,
        color: Colors.black,
      ),
      onPressed: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        } else if (onPress != null) {
          onPress!();
        }
      },
    );
  }
}

