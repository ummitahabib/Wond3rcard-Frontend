import 'package:flutter/material.dart';
import 'package:wond3rcard/src/utils/assets.dart';

class GetStartedBg extends StatelessWidget {
  const GetStartedBg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        ImageAssets.bgBlur,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
