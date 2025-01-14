import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gearforce/src/gearforce.dart';
import 'package:gearforce/src/pages/settings/settings_service.dart';
import 'package:gearforce/src/pages/settings/settings_bloc.dart';

void main() async {
  final settingsBloc = SettingsBloc(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  await settingsBloc.loadSettings();

  runApp(
    BlocProvider(
      create: (context) => settingsBloc,
      child: Gearforce(),
    ),
  );
}
