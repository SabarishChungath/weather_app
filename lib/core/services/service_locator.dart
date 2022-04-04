import 'package:climate_app/core/services/api/api_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() async {
  // locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerLazySingleton<ApiService>(() => ApiService());
}
