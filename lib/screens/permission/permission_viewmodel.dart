import 'dart:developer';

import 'package:climate_app/core/base/base_viewmodel.dart';
import 'package:climate_app/routes/routing_constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PermissionViewModel extends BaseViewModel {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  String locationErr = "";

  Future<void> onPressProceed(BuildContext context) async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    log("Navigating to home screen");
    Navigator.pushReplacementNamed(context, homeRoute);
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log("Service Not Enabled");

      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      // This means location has been turned of on device
      // Show message please turn on location
      locationErr = "Please turn on location on your device";
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      log("Permission Denied");
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        locationErr = "Click Give permissions to enable location permissions";
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log("Permission Denied Forever");
      // Permissions are denied forever, handle appropriately.
      // This means the user has denied the location request access
      // Show message to enable it from settings
      locationErr =
          "Location permission has been denied please give access from settings";
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return true;
  }
}
