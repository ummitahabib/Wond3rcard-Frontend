import 'package:flutter/material.dart';

Size getScreenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

class MediaQueryHelper {
  final BuildContext context;

  MediaQueryHelper(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  double get aspectRatio => MediaQuery.of(context).size.aspectRatio;
  EdgeInsets get padding => MediaQuery.of(context).padding;

  bool get isLandscape =>
      MediaQuery.of(context).orientation == Orientation.landscape;
  bool get isPortrait =>
      MediaQuery.of(context).orientation == Orientation.portrait;
}
