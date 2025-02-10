import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A provider that stores and retrieves user settings.
class SettingsProvider {
  static const String _themeModeKey = 'themeMode';

  SettingsProvider() {
    WidgetsFlutterBinding.ensureInitialized();
  }

  /// Loads the User's preferred ThemeMode from local storage.
  Future<ThemeMode> themeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex =
        prefs.getInt(_themeModeKey) ?? ThemeMode.system.index;
    return ThemeMode.values[themeModeIndex];
  }

  /// Persists the user's preferred ThemeMode to local storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, theme.index);
  }
}
