import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:gearforce/src/pages/settings/settings_service.dart';
import 'package:gearforce/src/pages/settings/settings_state.dart';
import 'package:gearforce/src/pages/settings/settings_events.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsService settingsService;

  SettingsBloc(this.settingsService)
      : super(SettingsInitial(ThemeMode.system)) {
    on<UpdateThemeMode>((event, emit) async {
      await settingsService.updateThemeMode(event.themeMode);
      emit(SettingsUpdated(event.themeMode));
    });
  }

  Future<void> loadSettings() async {
    final themeMode = await settingsService.themeMode();
    add(UpdateThemeMode(themeMode));
  }
}
