import 'dart:developer';

import 'package:climate_app/core/base/base_viewmodel.dart';
import 'package:climate_app/core/models/weather.dart';
import 'package:climate_app/core/services/api/api_service.dart';
import 'package:climate_app/core/services/errors/exceptions.dart';
import 'package:geolocator/geolocator.dart';

class HomeViewModel extends BaseViewModel {
  Weather? weather;
  late Future future;

  onInit() async {
    future = loadWeather();
  }

  loadWeather() async {
    try {
      Position _position = await getCurrentLocation();
      var response = await apiService.fetchClimate(
          lat: _position.latitude, long: _position.longitude);
      weather = Weather.fromJson(response);
      log(weather!.hourly!.length.toString());
      log(weather!.daily!.first.weather!.first.id.toString());
      log(weather!.daily!.first.weather!.first.title.toString());
    } catch (e) {
      if (e is AppException) {
        log("err: ${e.message}");
      }
    }
  }

  getCurrentLocation() async {
    Position position = await GeolocatorPlatform.instance.getCurrentPosition();
    log("position: $position");
    return position;
  }
}
