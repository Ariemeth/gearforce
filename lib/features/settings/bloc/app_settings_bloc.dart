import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/features/settings/bloc/app_settings_events.dart';
import 'package:gearforce/features/settings/bloc/app_settings_repository.dart';
import 'package:gearforce/features/settings/bloc/app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvents, AppSettingsState> {
  final AppSettingsRepository _settingsProvider;

  AppSettingsBloc(this._settingsProvider)
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
