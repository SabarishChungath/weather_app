import 'package:climate_app/screens/splash/splash_view.dart';
import 'package:climate_app/screens/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashViewModel(),
      lazy: true,
      child: const SplashView(),
    );
  }
}
