import 'package:material_ui/material_ui.dart';
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
            create: (context) => AppSettingsCubit(
              RepositoryProvider.of<AppSettingsRepository>(context),
            )..loadSettings(),
          ),
          BlocProvider(
            create: (context) =>
                RosterCubit(RepositoryProvider.of<UnitRepository>(context)),
          ),
        ],
        child: const Gearforce(),
      ),
    ),
  );
}
