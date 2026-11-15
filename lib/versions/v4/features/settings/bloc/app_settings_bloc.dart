import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/models/rule_version.dart';
import 'package:gearforce/versions/v4/features/settings/bloc/app_settings_repository.dart';
import 'package:gearforce/versions/v4/features/settings/bloc/app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  final AppSettingsRepository _settingsProvider;

  AppSettingsCubit(this._settingsProvider) : super(SettingsInitial());

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _settingsProvider.updateThemeMode(themeMode);
    emit(
      SettingsUpdated(
        themeMode: themeMode,
        uiDisplayMode: state.uiDisplayMode,
        ruleVersion: state.ruleVersion,
      ),
    );
  }

  Future<void> updateUiDisplayMode(UiDisplayMode uiDisplayMode) async {
    await _settingsProvider.updateUiDisplayMode(uiDisplayMode);
    emit(
      SettingsUpdated(
        themeMode: state.themeMode,
        uiDisplayMode: uiDisplayMode,
        ruleVersion: state.ruleVersion,
      ),
    );
  }

  Future<void> updateRuleVersion(RuleVersion ruleVersion) async {
    await _settingsProvider.updateRuleVersion(ruleVersion);
    emit(
      SettingsUpdated(
        themeMode: state.themeMode,
        uiDisplayMode: state.uiDisplayMode,
        ruleVersion: ruleVersion,
      ),
    );
  }

  Future<void> loadSettings() async {
    final themeMode = await _settingsProvider.themeMode();
    final uiDisplayMode = await _settingsProvider.uiDisplayMode();
    final ruleVersion = await _settingsProvider.ruleVersion();
    emit(
      SettingsUpdated(
        themeMode: themeMode,
        uiDisplayMode: uiDisplayMode,
        ruleVersion: ruleVersion,
      ),
    );
  }
}
