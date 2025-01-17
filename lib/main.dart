import 'package:flutter/material.dart';
import 'package:loot_vault/app/app.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/core/network/hive_service.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  await initDependencies();
  runApp(const MyApp());
}
