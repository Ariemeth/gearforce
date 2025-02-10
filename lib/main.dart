import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gearforce/src/gearforce.dart';
import 'package:gearforce/src/pages/settings/bloc/settings_provider.dart';
import 'package:gearforce/src/pages/settings/bloc/settings_bloc.dart';

void main() async {
  runApp(
    RepositoryProvider(
      create: (context) => SettingsProvider(),
      child: BlocProvider(
        create: (context) =>
            SettingsBloc(RepositoryProvider.of<SettingsProvider>(context))
              ..loadSettings(),
        child: Gearforce(),
      ),
    ),
  );
}
