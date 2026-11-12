import 'package:material_ui/material_ui.dart';

enum UiDisplayMode { auto, mobile, desktop }

sealed class AppSettingsState {
  final ThemeMode themeMode;
  final UiDisplayMode uiDisplayMode;

  AppSettingsState({required this.themeMode, required this.uiDisplayMode});
}

class SettingsInitial extends AppSettingsState {
  SettingsInitial({
    super.themeMode = ThemeMode.system,
    super.uiDisplayMode = UiDisplayMode.auto,
  });
}

class SettingsUpdated extends AppSettingsState {
  SettingsUpdated({required super.themeMode, required super.uiDisplayMode});
}
