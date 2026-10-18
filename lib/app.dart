import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gearforce/core/generated/i18n/app_localizations.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/core/utils/platform_utils.dart';
import 'package:gearforce/features/settings/bloc/app_settings_bloc.dart';
import 'package:gearforce/features/settings/bloc/app_settings_state.dart';
import 'package:gearforce/features/settings/screens/app_settings_screen.dart';
import 'package:gearforce/features/roster/screens/roster_screen.dart';
import 'package:gearforce/features/roster/screens/weapon_display_screen.dart';

class Gearforce extends StatelessWidget {
  const Gearforce({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) => context.l10n.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme:
              ThemeData.from(
                colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
              ).copyWith(
                visualDensity: PlatformUtils.adaptiveVisualDensity,
                tooltipTheme: const TooltipThemeData(
                  waitDuration: AppTheme.tooltipWaitDuration,
                ),
              ),
          darkTheme: ThemeData.dark().copyWith(
            visualDensity: PlatformUtils.adaptiveVisualDensity,
            tooltipTheme: const TooltipThemeData(
              waitDuration: AppTheme.tooltipWaitDuration,
            ),
          ),
          themeMode: state.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case AppSettingScreen.routeName:
                    return const AppSettingScreen();
                  case WeaponDisplayScreen.routeName:
                    return const WeaponDisplayScreen();
                  default:
                    return const RosterScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}
