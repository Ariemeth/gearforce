import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/pages/settings/bloc/settings_bloc.dart';
import 'package:gearforce/src/pages/settings/bloc/settings_events.dart';
import 'package:gearforce/src/pages/settings/bloc/settings_state.dart';

const _pagePadding = EdgeInsets.all(16);

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Settings')),
      body: Padding(
        padding: _pagePadding,
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return DropdownButtonFormField<ThemeMode>(
              initialValue: state.themeMode,
              onChanged: (newThemeMode) {
                if (newThemeMode != null && newThemeMode != state.themeMode) {
                  context.read<SettingsBloc>().add(
                    UpdateThemeMode(newThemeMode),
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
