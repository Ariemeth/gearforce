import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
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
        title: Text(context.l10n.appSettingsTitle(context.l10n.appTitle)),
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
              decoration: InputDecoration(
                labelText: context.l10n.settingsThemeLabel,
                helperText: context.l10n.settingsThemeHelper,
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(context.l10n.settingsThemeSystem),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(context.l10n.settingsThemeLight),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(context.l10n.settingsThemeDark),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
