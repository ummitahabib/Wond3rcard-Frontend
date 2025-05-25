import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/app_widget.dart';
import 'package:geolocator_web/geolocator_web.dart';
import 'package:wond3rcard/src/utils/util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GeolocatorPlatform.instance = GeolocatorPlatform.instance;
  await StorageUtil.init();
  runApp(const ProviderScope(child: AppWidget()));
}
