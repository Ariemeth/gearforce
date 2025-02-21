import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gearforce/src/gearforce.dart';
import 'package:gearforce/src/pages/settings/bloc/settings_provider.dart';
import 'package:gearforce/src/pages/settings/bloc/settings_bloc.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';

void main() async {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SettingsRepository>(
          create: (context) => SettingsRepository(),
        ),
        // Add other repositories here if needed
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsBloc(
              RepositoryProvider.of<SettingsRepository>(context),
            )..loadSettings(),
          ),
          BlocProvider(
            create: (context) => RosterBloc(),
          ),
          // Add other BlocProviders here if needed
        ],
        child: Gearforce(),
      ),
    ),
  );
}
