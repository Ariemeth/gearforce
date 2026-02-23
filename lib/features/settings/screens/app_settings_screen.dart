import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/generated/i18n/app_localizations.dart';
import 'package:gearforce/features/settings/bloc/app_settings_bloc.dart';
import 'package:gearforce/features/settings/bloc/app_settings_events.dart';
import 'package:gearforce/features/settings/bloc/app_settings_state.dart';

const _pagePadding = EdgeInsets.all(16);

class AppSettingScreen extends StatelessWidget {
  const AppSettingScreen({super.key});

  static const routeName = '/app_settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context)!.appTitle} Settings'),
      ),
      body: Padding(
        padding: _pagePadding,
        child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
          builder: (context, state) {
            return DropdownButtonFormField<ThemeMode>(
              initialValue: state.themeMode,
              onChanged: (newThemeMode) {
                if (newThemeMode != null && newThemeMode != state.themeMode) {
                  context.read<AppSettingsBloc>().add(
                    UpdateThemeMode(themeMode: newThemeMode),
                  );
                }
              },
              decoration: const InputDecoration(
                labelText: 'Theme',
                helperText: 'Choose how the app looks',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System'),
                ),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
            );
          },
        ),
      ),
    );
  }
}
