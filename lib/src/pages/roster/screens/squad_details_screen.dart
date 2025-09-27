import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/pages/roster/widgets/select_model_button.dart';
import 'package:gearforce/src/pages/roster/widgets/squad_level_selector.dart';
import 'package:gearforce/src/pages/roster/widgets/squad_role_selectors.dart';
import 'package:gearforce/src/theme/app_theme.dart';

const _pagePadding = EdgeInsets.fromLTRB(8, 5, 8, 5);

class SquadDetailsScreen extends StatelessWidget {
  final int squadId;

  const SquadDetailsScreen({super.key, required this.squadId});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RosterBloc, RosterState, Squad?>(
      selector: (state) {
        try {
          return state.squads.firstWhere((s) => s.id == squadId);
        } on StateError catch (_, _) {
          return null;
        }
      },
      builder: (context, squad) {
        if (squad == null) {
          return Scaffold(
            appBar: AppBar(title: Text('Squad $squadId')),
            body: Center(child: Text('No Squad with id $squadId is found')),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(squad.name)),
          body: Padding(
            padding: _pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SquadRoleSelectors(squad: squad),
                Column(
                  children: [
                    // TODO convert this Row into its own widget
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TV: ${squad.tv}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SquadLevelSelector(squadId: squadId),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: squad.models.length,
                    itemBuilder: (context, index) {
                      final unit = squad.models[index];
                      return ListTile(
                        title: Text(unit.name, style: AppTheme.bodyStyle),
                        subtitle: Text('TV: ${unit.tv}'),
                        contentPadding: AppTheme.listTilePadding,
                      );
                    },
                  ),
                ),
                Center(child: SelectModelButton(updatedSquad: squad)),
              ],
            ),
          ),
        );
      },
    );
  }
}
