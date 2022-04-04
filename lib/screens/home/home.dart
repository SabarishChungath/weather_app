import 'package:climate_app/screens/home/home_view.dart';
import 'package:climate_app/screens/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      lazy: true,
      child: const HomeView(),
    );
  }
}
