import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gearforce/src/pages/settings/settings_bloc.dart';
import 'package:gearforce/src/pages/settings/settings_event.dart';
import 'package:gearforce/src/pages/settings/settings_state.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return DropdownButton<ThemeMode>(
              value: state.themeMode,
              onChanged: (newThemeMode) {
                context
                    .read<SettingsBloc>()
                    .add(UpdateThemeMode(newThemeMode!));
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
