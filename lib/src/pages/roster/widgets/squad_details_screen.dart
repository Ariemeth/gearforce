import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/pages/roster/widgets/select_model_button.dart';
import 'package:gearforce/src/pages/roster/widgets/squad_role_selectors.dart';
import 'package:gearforce/src/theme/app_theme.dart';

class SquadDetailsScreen extends StatelessWidget {
  final Squad squad;

  const SquadDetailsScreen({super.key, required this.squad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(squad.name), // Use name instead of id
      ),
      body: BlocBuilder<RosterBloc, RosterState>(
        builder: (context, state) {
          // Find the updated squad from the state
          final updatedSquad = state.squads.firstWhere(
            (s) => s.name == squad.name,
          );

          return Padding(
            padding: AppTheme.defaultPagePadding,
            child: Column(
              children: [
                SquadRoleSelectors(squad: updatedSquad),
                Expanded(
                  child: ListView.builder(
                    itemCount: updatedSquad.models.length,
                    itemBuilder: (context, index) {
                      final unit = updatedSquad.models[index];
                      return ListTile(
                        title: Text(
                          'Unit: ${unit.name}',
                          style: AppTheme.bodyStyle,
                        ),
                        subtitle: Text('TV: ${unit.tv}'),
                        contentPadding: AppTheme.listTilePadding,
                      );
                    },
                  ),
                ),
                SelectModelButton(updatedSquad: updatedSquad),
              ],
            ),
          );
        },
      ),
    );
  }
}
