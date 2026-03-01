import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/app.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/data/repositories/json_unit_repository.dart';
import 'package:gearforce/features/settings/bloc/app_settings_bloc.dart';
import 'package:gearforce/features/settings/bloc/app_settings_repository.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppSettingsRepository>(
          create: (context) => AppSettingsRepository(),
        ),
        RepositoryProvider<UnitRepository>(
          create: (context) => JsonUnitRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppSettingsBloc(
              RepositoryProvider.of<AppSettingsRepository>(context),
            )..loadSettings(),
          ),
          BlocProvider(
            create: (context) =>
                RosterBloc(RepositoryProvider.of<UnitRepository>(context)),
          ),
        ],
        child: const Gearforce(),
      ),
    ),
  );
}
