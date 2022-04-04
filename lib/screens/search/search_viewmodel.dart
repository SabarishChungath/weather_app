import 'dart:developer';

import 'package:climate_app/core/base/base_viewmodel.dart';
import 'package:climate_app/core/models/weather.dart';
import 'package:climate_app/core/services/api/api_service.dart';
import 'package:climate_app/core/services/errors/exceptions.dart';
import 'package:flutter/cupertino.dart';

class SearchViewModel extends BaseViewModel {
  Future? future;
  late TextEditingController controller;
  Weather? weather;

  onInit() {
    controller = TextEditingController();
  }

  onSubmit() async {
    future = fetchWeather();
    notifyListeners();
  }

  fetchWeather() async {
    try {
      var response = await fetchGeoCode();
      double? latitude = response.first["lat"];
      double? longitude = response.first["lon"];
      if (latitude != null && longitude != null) {
        var response =
            await apiService.fetchClimate(lat: latitude, long: longitude);
        weather = Weather.fromJson(response);
        notifyListeners();
      } else {
        throw ClientException(message: "Something went wrong");
      }
    } catch (e) {
      if (e is AppException) {
        return Future.error(e.message ?? "Something went wrong");
      } else {
        return Future.error("Something went wrong");
      }
    }
  }

  fetchGeoCode() async {
    try {
      var response = await apiService.fetchGeoCode(controller.text);
      if (response.isEmpty) {
        throw ClientException(message: "No such location");
      } else {
        return response;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
