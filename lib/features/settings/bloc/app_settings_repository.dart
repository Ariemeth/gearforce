import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A provider that stores and retrieves user app_settings.
class AppSettingsRepository {
  static const String _themeModeKey = 'themeMode';
  static const _themeModeDark = 'dark';
  static const _themeModeLight = 'light';
  static const _themeModeSystem = 'system';

  AppSettingsRepository();

  /// Loads the User's preferred ThemeMode from local storage.
  Future<ThemeMode> themeMode() async {
    final prefs = SharedPreferencesAsync();

    try {
      final themeMode =
          await prefs.getString(_themeModeKey) ?? _themeModeSystem;
      return switch (themeMode) {
        _themeModeDark => ThemeMode.dark,
        _themeModeLight => ThemeMode.light,
        _ => ThemeMode.system,
      };
    } catch (e) {
      developer.log(
        'Unable to load theme mode',
        name: 'AppSettingsRepository',
        error: e,
      );
      return ThemeMode.system;
    }
  }

  /// Persists the user's preferred ThemeMode to local storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = SharedPreferencesAsync();

    final themeMode = switch (theme) {
      ThemeMode.light => _themeModeLight,
      ThemeMode.dark => _themeModeDark,
      _ => _themeModeSystem,
    };
    try {
      await prefs.setString(_themeModeKey, themeMode);
    } catch (e) {
      developer.log(
        'Unable to save theme mode',
        name: 'AppSettingsRepository',
        error: e,
      );
    }
  }
}
