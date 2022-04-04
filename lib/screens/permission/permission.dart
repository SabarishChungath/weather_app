import 'package:climate_app/screens/permission/permission_view.dart';
import 'package:climate_app/screens/permission/permission_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PermissionViewModel(),
      lazy: true,
      child: const PermissionView(),
    );
  }
}
