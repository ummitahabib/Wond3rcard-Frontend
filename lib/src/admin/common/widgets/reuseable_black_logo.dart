import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/assets.dart';

class ReusableWonderCardLogo extends StatelessWidget {
  const ReusableWonderCardLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageAssets.wonderCardLogoBlack,
    );
  }
}
