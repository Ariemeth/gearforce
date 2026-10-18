import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gearforce/core/generated/i18n/app_localizations.dart';
import 'package:gearforce/core/routing/app_router.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/core/utils/platform_utils.dart';
import 'package:gearforce/features/settings/bloc/app_settings_bloc.dart';
import 'package:gearforce/features/settings/bloc/app_settings_state.dart';

class Gearforce extends StatelessWidget {
  const Gearforce({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        return MaterialApp.router(
          routerConfig: appRouter,
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', '')],
          onGenerateTitle: (BuildContext context) => context.l10n.appTitle,
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
        );
      },
    );
  }
}
