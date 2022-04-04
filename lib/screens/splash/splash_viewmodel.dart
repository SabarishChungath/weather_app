import 'dart:developer';

import 'package:climate_app/core/base/base_viewmodel.dart';
import 'package:climate_app/routes/routing_constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SplashViewModel extends BaseViewModel {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<LocationStatus> checkForPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationStatus.noService;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      return LocationStatus.denied;
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationStatus.deniedForever;
    }

    return LocationStatus.granted;
  }

  nextPage(BuildContext context) async {
    LocationStatus permissionStatus = await checkForPermissions();
    if (permissionStatus == LocationStatus.granted) {
      //navigate to home page
      log("navigating to home screen");
      Navigator.pushReplacementNamed(context, homeRoute);
    } else {
      //navigate to permissions screen
      log("navigating to permissions screen: $permissionStatus");
      Navigator.pushReplacementNamed(context, permissionRoute);
    }
  }
}

enum LocationStatus { granted, denied, deniedForever, noService }
