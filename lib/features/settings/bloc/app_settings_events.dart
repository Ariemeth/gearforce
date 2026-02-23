import 'package:flutter/material.dart';

abstract class AppSettingsEvents {}

class UpdateThemeMode extends AppSettingsEvents {
  final ThemeMode themeMode;

  UpdateThemeMode({required this.themeMode});
}
