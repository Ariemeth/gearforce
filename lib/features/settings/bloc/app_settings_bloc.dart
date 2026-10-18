import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/features/settings/bloc/app_settings_repository.dart';
import 'package:gearforce/features/settings/bloc/app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  final AppSettingsRepository _settingsProvider;

  AppSettingsCubit(this._settingsProvider)
    : super(SettingsInitial(ThemeMode.system));

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _settingsProvider.updateThemeMode(themeMode);
    emit(SettingsUpdated(themeMode));
  }

  Future<void> loadSettings() async {
    final themeMode = await _settingsProvider.themeMode();
    emit(SettingsUpdated(themeMode));
  }
}
