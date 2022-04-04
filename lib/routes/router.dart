import 'package:climate_app/routes/routing_constants.dart';
import 'package:climate_app/screens/home/home.dart';
import 'package:climate_app/screens/permission/permission.dart';
import 'package:climate_app/screens/search/search.dart';
import 'package:climate_app/screens/splash/splash.dart';
import 'package:flutter/material.dart'
    show MaterialPageRoute, Route, RouteSettings;

Route<dynamic> generateRoute(RouteSettings settings) {
  String? routeName = settings.name;
  Object? args = settings.arguments;

  switch (routeName) {
    case splashRoute:
      return MaterialPageRoute(builder: (context) => const SplashScreen());

    case permissionRoute:
      return MaterialPageRoute(builder: (context) => const PermissionScreen());

    case homeRoute:
      return MaterialPageRoute(builder: (context) => const HomeScreen());

    case searchRoute:
      return MaterialPageRoute(builder: (context) => const SearchScreen());

    default:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
  }
}
