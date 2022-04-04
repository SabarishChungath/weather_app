import 'package:climate_app/app.dart';
import 'package:climate_app/core/services/database/db_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/services/service_locator.dart';

void main() async {
  await initialize();
  runApp(const MyApp());
}

initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // for dependecy Injection
  setupLocator();

  //db init
  await dbInit();
}
