import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A provider that stores and retrieves user settings.
class SettingsRepository {
  static const String _themeModeKey = 'themeMode';
  static const _themeModeDark = 'dark';
  static const _themeModeLight = 'light';
  static const _themeModeSystem = 'system';

  SettingsRepository();

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
      print('Unable to load theme mode: error=$e');
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
      print('Unable to save theme mode: error=$e');
    }
  }
}
