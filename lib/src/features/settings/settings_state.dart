import 'package:flutter/material.dart';

sealed class SettingsState {
  final ThemeMode themeMode;

  SettingsState(this.themeMode);
}

class SettingsInitial extends SettingsState {
  SettingsInitial(super.themeMode);
}

class SettingsUpdated extends SettingsState {
  SettingsUpdated(super.themeMode);
}
