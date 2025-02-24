import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/app_widget.dart';
import 'package:wond3rcard/src/utils/storage_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await StorageUtil.init(); 
  runApp(const ProviderScope(child: AppWidget())); 
}