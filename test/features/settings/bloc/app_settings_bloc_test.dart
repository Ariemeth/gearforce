import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:gearforce/features/settings/bloc/app_settings_bloc.dart';
import 'package:gearforce/features/settings/bloc/app_settings_repository.dart';
import 'package:gearforce/features/settings/bloc/app_settings_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppSettingsCubit', () {
    late AppSettingsRepository repository;
    late AppSettingsCubit cubit;

    setUp(() {
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();
      repository = AppSettingsRepository();
      cubit = AppSettingsCubit(repository);
    });

    tearDown(() {
      cubit.close();
    });

    test(
      'initial state has default ThemeMode.system and UiDisplayMode.auto',
      () {
        expect(cubit.state.themeMode, ThemeMode.system);
        expect(cubit.state.uiDisplayMode, UiDisplayMode.auto);
      },
    );

    test('updateUiDisplayMode updates state and persists mode', () async {
      await cubit.updateUiDisplayMode(UiDisplayMode.mobile);

      expect(cubit.state.uiDisplayMode, UiDisplayMode.mobile);

      final persistedMode = await repository.uiDisplayMode();
      expect(persistedMode, UiDisplayMode.mobile);
    });

    test('loadSettings loads persisted theme and uiDisplayMode', () async {
      await repository.updateUiDisplayMode(UiDisplayMode.desktop);
      await repository.updateThemeMode(ThemeMode.dark);

      await cubit.loadSettings();

      expect(cubit.state.themeMode, ThemeMode.dark);
      expect(cubit.state.uiDisplayMode, UiDisplayMode.desktop);
    });
  });
}
