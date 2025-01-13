import 'package:flutter/material.dart';

abstract class SettingsEvent {}

class UpdateThemeMode extends SettingsEvent {
  final ThemeMode themeMode;

  UpdateThemeMode(this.themeMode);
}
