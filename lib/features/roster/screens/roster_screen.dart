import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/large_roster_display.dart';
import 'package:gearforce/features/roster/widgets/roster_page_drawer.dart';
import 'package:gearforce/features/roster/widgets/small_roster_display.dart';
import 'package:gearforce/core/widgets/display_layout_constraints.dart';
import 'package:gearforce/core/widgets/responsive_size.dart';

const _pagePadding = EdgeInsets.fromLTRB(3, 2, 3, 2);

class RosterScreen extends StatelessWidget {
  const RosterScreen({super.key});

  static const routeName = '/roster';

  @override
  Widget build(BuildContext context) {
    final title = context.l10n.appTitle;
    final screenSize = ResponsiveSize.getScreenSize(context);
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
            tooltip: context.l10n.rosterSettingsTooltip,
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
      drawer: RosterPageDrawer(title: title, screenSize: screenSize),
    );
  }
}
