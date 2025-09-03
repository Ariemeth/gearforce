import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/pages/roster/widgets/large_roster_display.dart';
import 'package:gearforce/src/pages/roster/widgets/roster_page_drawer.dart';
import 'package:gearforce/src/pages/roster/widgets/small_roster_display.dart';
import 'package:gearforce/src/widgets/display_layout_constraints.dart';
import 'package:gearforce/src/widgets/responsive_size.dart';

const _pagePadding = EdgeInsets.fromLTRB(3, 2, 3, 2);

class RosterScreen extends StatelessWidget {
  const RosterScreen({super.key});

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
              // TODO add roster settings
              print('Roster settings clicked');
            },
            tooltip: 'Roster Settings',
          ),
        ],
      ),
      body: BlocBuilder<RosterBloc, RosterState>(
        builder: (context, state) {
          return Padding(
            padding: _pagePadding,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenSize = ResponsiveSize.getScreenSize(context);
                final rosterMetaData = DisplayLayoutConstraints(
                  maxScreenWidth: constraints.maxWidth,
                  maxScreenHeight: constraints.maxHeight,
                );

                switch (screenSize) {
                  case ScreenSize.small:
                    return SmallRosterDisplay(rosterMetaData: rosterMetaData);
                  case ScreenSize.large:
                    return LargeRosterDisplay(rosterMetaData: rosterMetaData);
                }
              },
            ),
          );
        },
      ),
      drawer: RosterPageDrawer(title: title),
    );
  }
}
