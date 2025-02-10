import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:gearforce/src/pages/settings/bloc/settings_provider.dart';
import 'package:gearforce/src/pages/settings/bloc/settings_state.dart';
import 'package:gearforce/src/pages/settings/bloc/settings_events.dart';

class SettingsBloc extends Bloc<SettingsEvents, SettingsState> {
  final SettingsProvider _settingsProvider;

  SettingsBloc(this._settingsProvider)
      : super(SettingsInitial(ThemeMode.system)) {
    on<UpdateThemeMode>((event, emit) async {
      await _settingsProvider.updateThemeMode(event.themeMode);
      emit(SettingsUpdated(event.themeMode));
    });
  }

  Future<void> loadSettings() async {
    final themeMode = await _settingsProvider.themeMode();
    add(UpdateThemeMode(themeMode));
  }

  void changeThemeMode(ThemeMode newThemeMode) {
    add(UpdateThemeMode(newThemeMode));
  }
}
