import 'dart:developer' as developer;
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gearforce/features/settings/bloc/app_settings_state.dart';

/// A provider that stores and retrieves user app_settings.
class AppSettingsRepository {
  static const String _themeModeKey = 'themeMode';
  static const _themeModeDark = 'dark';
  static const _themeModeLight = 'light';
  static const _themeModeSystem = 'system';

  static const String _uiDisplayModeKey = 'uiDisplayMode';
  static const _uiModeAuto = 'auto';
  static const _uiModeMobile = 'mobile';
  static const _uiModeDesktop = 'desktop';

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

  /// Loads the User's preferred UiDisplayMode from local storage.
  Future<UiDisplayMode> uiDisplayMode() async {
    final prefs = SharedPreferencesAsync();

    try {
      final uiMode = await prefs.getString(_uiDisplayModeKey) ?? _uiModeAuto;
      return switch (uiMode) {
        _uiModeMobile => UiDisplayMode.mobile,
        _uiModeDesktop => UiDisplayMode.desktop,
        _ => UiDisplayMode.auto,
      };
    } catch (e) {
      developer.log(
        'Unable to load UI display mode',
        name: 'AppSettingsRepository',
        error: e,
      );
      return UiDisplayMode.auto;
    }
  }

  /// Persists the user's preferred UiDisplayMode to local storage.
  Future<void> updateUiDisplayMode(UiDisplayMode mode) async {
    final prefs = SharedPreferencesAsync();

    final uiModeStr = switch (mode) {
      UiDisplayMode.mobile => _uiModeMobile,
      UiDisplayMode.desktop => _uiModeDesktop,
      _ => _uiModeAuto,
    };
    try {
      await prefs.setString(_uiDisplayModeKey, uiModeStr);
    } catch (e) {
      developer.log(
        'Unable to save UI display mode',
        name: 'AppSettingsRepository',
        error: e,
      );
    }
  }
}
