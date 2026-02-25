import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/core/widgets/responsive_layout.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/large_roster_display.dart';
import 'package:gearforce/features/roster/widgets/roster_page_drawer.dart';
import 'package:gearforce/features/roster/widgets/small_roster_display.dart';

const _pagePadding = EdgeInsets.fromLTRB(2, 1, 5, 6);

class RosterScreen extends StatelessWidget {
  const RosterScreen({super.key});

  static const routeName = '/roster';

  @override
  Widget build(BuildContext context) {
    final title = context.l10n.appTitle;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO add roster settings
            },
            tooltip: context.l10n.rosterSettingsTooltip,
          ),
        ],
      ),
      body: BlocBuilder<RosterBloc, RosterState>(
        builder: (context, state) {
          return Padding(
            padding: _pagePadding,
            child: ResponsiveLayout(
              compact: SmallRosterDisplay(state: state),
              expanded: LargeRosterDisplay(state: state),
            ),
          );
        },
      ),
      drawer: RosterPageDrawer(title: title),
    );
  }
}
