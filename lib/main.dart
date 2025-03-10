import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/app_widget.dart';
import 'package:wond3rcard/src/utils/app_router.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';
import 'package:geolocator_web/geolocator_web.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await setupRouter();
  GeolocatorPlatform.instance = GeolocatorPlatform.instance;
  await StorageUtil.init();
  runApp(
    
    const ProviderScope(child: AppWidget()));
}
