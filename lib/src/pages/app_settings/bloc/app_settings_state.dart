import 'package:flutter/material.dart';

sealed class AppSettingsState {
  final ThemeMode themeMode;

  AppSettingsState(this.themeMode);
}

class SettingsInitial extends AppSettingsState {
  SettingsInitial(super.themeMode);
}

class SettingsUpdated extends AppSettingsState {
  SettingsUpdated(super.themeMode);
}
