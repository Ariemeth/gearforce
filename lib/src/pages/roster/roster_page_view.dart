import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/pages/roster/widgets/large_roster_display.dart';
import 'package:gearforce/src/pages/roster/widgets/small_roster_display.dart';
import 'package:gearforce/src/pages/roster/widgets/roster_page_drawer.dart';
import 'package:gearforce/src/pages/settings/settings_page_view.dart';
import 'package:gearforce/src/widgets/display_layout_constraints.dart';
import 'package:gearforce/src/widgets/responsive_size.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';

class RosterPageView extends StatelessWidget {
  const RosterPageView({super.key});

  static const routeName = '/roster';

  @override
  Widget build(BuildContext context) {
    final title = AppLocalizations.of(context)!.appTitle;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(
                context,
                SettingsPageView.routeName,
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<RosterBloc, RosterState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final screenSize = ResponsiveSize.getScreenSize(context);
              final rosterMetaData = DisplayLayoutConstraints(
                minScreenWidth: constraints.minWidth,
                maxScreenWidth: constraints.maxWidth,
                minScreenHeight: constraints.minHeight,
                maxScreenHeight: constraints.maxHeight,
              );

              switch (screenSize) {
                case ScreenSize.small:
                  return SmallRosterDisplay(rosterMetaData: rosterMetaData);
                case ScreenSize.large:
                  return LargeRosterDisplay(rosterMetaData: rosterMetaData);
              }
            },
          );
        },
      ),
      drawer: RosterPageDrawer(title: title),
    );
  }
}
