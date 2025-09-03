import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/pages/app_settings/bloc/app_settings_events.dart';
import 'package:gearforce/src/pages/app_settings/bloc/app_settings_provider.dart';
import 'package:gearforce/src/pages/app_settings/bloc/app_settings_state.dart';

class SettingsBloc extends Bloc<AppSettingsEvents, AppSettingsState> {
  final AppSettingsRepository _settingsProvider;

  SettingsBloc(this._settingsProvider)
    : super(SettingsInitial(ThemeMode.system)) {
    on<UpdateThemeMode>((event, emit) async {
      await _settingsProvider.updateThemeMode(event.themeMode);
      emit(SettingsUpdated(event.themeMode));
    });
  }

  Future<void> loadSettings() async {
    final themeMode = await _settingsProvider.themeMode();
    add(UpdateThemeMode(themeMode: themeMode));
  }
}
