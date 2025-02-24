import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';

final sharedProvider = ChangeNotifierProvider<SharedController>((ref) {
  return SharedController(ref);
});

class SharedController extends ChangeNotifier {
  final Ref ref;

  SharedController(this.ref);

  String address = emptyString;
  LatLng selectedLocation = const LatLng(37.7749, -122.4194);
}
