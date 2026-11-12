import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/features/settings/bloc/app_settings_repository.dart';
import 'package:gearforce/features/settings/bloc/app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  final AppSettingsRepository _settingsProvider;

  AppSettingsCubit(this._settingsProvider) : super(SettingsInitial());

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _settingsProvider.updateThemeMode(themeMode);
    emit(
      SettingsUpdated(themeMode: themeMode, uiDisplayMode: state.uiDisplayMode),
    );
  }

  Future<void> updateUiDisplayMode(UiDisplayMode uiDisplayMode) async {
    await _settingsProvider.updateUiDisplayMode(uiDisplayMode);
    emit(
      SettingsUpdated(themeMode: state.themeMode, uiDisplayMode: uiDisplayMode),
    );
  }

  Future<void> loadSettings() async {
    final themeMode = await _settingsProvider.themeMode();
    final uiDisplayMode = await _settingsProvider.uiDisplayMode();
    emit(SettingsUpdated(themeMode: themeMode, uiDisplayMode: uiDisplayMode));
  }
}
