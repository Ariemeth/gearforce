import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/gearforce.dart';
import 'package:gearforce/src/pages/app_settings/bloc/app_settings_bloc.dart';
import 'package:gearforce/src/pages/app_settings/bloc/app_settings_provider.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppSettingsRepository>(
          create: (context) => AppSettingsRepository(),
        ),
        // Add other repositories here if needed
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppSettingsBloc(
              RepositoryProvider.of<AppSettingsRepository>(context),
            )..loadSettings(),
          ),
          BlocProvider(create: (context) => RosterBloc()),
          // Add other BlocProviders here if needed
        ],
        child: Gearforce(),
      ),
    ),
  );
}
