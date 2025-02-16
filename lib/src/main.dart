import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/pages/home/home_page_view.dart';
import 'package:gearforce/src/pages/settings/bloc/settings_bloc.dart';
import 'package:gearforce/src/pages/settings/bloc/settings_provider.dart';
import 'package:gearforce/src/pages/settings/settings_page_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsBloc(SettingsRepository()),
        ),
        // Add other BlocProviders here if needed
      ],
      child: MaterialApp(
        title: 'Gearforce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePageView(),
        routes: {
          SettingsPageView.routeName: (context) => const SettingsPageView(),
          // Add other routes here if needed
        },
      ),
    );
  }
}
