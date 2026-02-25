import 'package:flutter/material.dart';

abstract class AppSettingsEvent {}

class UpdateThemeMode extends AppSettingsEvent {
  final ThemeMode themeMode;

  UpdateThemeMode({required this.themeMode});
}
