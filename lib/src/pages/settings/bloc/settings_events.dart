import 'package:flutter/material.dart';

abstract class SettingsEvents {}

class UpdateThemeMode extends SettingsEvents {
  final ThemeMode themeMode;

  UpdateThemeMode(this.themeMode);
}
