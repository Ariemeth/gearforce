import 'package:material_ui/material_ui.dart';
import 'package:gearforce/core/models/rule_version.dart';

enum UiDisplayMode { auto, mobile, desktop }

sealed class AppSettingsState {
  final ThemeMode themeMode;
  final UiDisplayMode uiDisplayMode;
  final RuleVersion ruleVersion;

  AppSettingsState({
    required this.themeMode,
    required this.uiDisplayMode,
    required this.ruleVersion,
  });
}

class SettingsInitial extends AppSettingsState {
  SettingsInitial({
    super.themeMode = ThemeMode.system,
    super.uiDisplayMode = UiDisplayMode.auto,
    super.ruleVersion = RuleVersion.v4_0,
  });
}

class SettingsUpdated extends AppSettingsState {
  SettingsUpdated({
    required super.themeMode,
    required super.uiDisplayMode,
    required super.ruleVersion,
  });
}
