import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wond3rcard/app_widget.dart';
import 'package:geolocator_web/geolocator_web.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/getcard.dart';
import 'package:wond3rcard/src/utils/util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GeolocatorPlatform.instance = GeolocatorPlatform.instance;
  await StorageUtil.init();
  await Hive.initFlutter();
  Hive.registerAdapter(GetCardAdapter());
  Hive.registerAdapter(PayloadAdapter());
  Hive.registerAdapter(CardDataAdapter());
  Hive.registerAdapter(ContactInfoAdapter());
  runApp(const ProviderScope(child: AppWidget()));
}
