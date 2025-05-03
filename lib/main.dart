import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/app_widget.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:geolocator_web/geolocator_web.dart';
//prod

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GeolocatorPlatform.instance = GeolocatorPlatform.instance;
  await StorageUtil.init();
  runApp(const ProviderScope(child: AppWidget()));
}



