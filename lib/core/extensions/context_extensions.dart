import 'package:flutter/material.dart';

extension GetTheme on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get typo => Theme.of(this).textTheme;
}
