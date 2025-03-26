import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/pages/roster/models/squad.dart';
import 'package:gearforce/src/pages/roster/models/unit.dart';
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
          final updatedSquad =
              state.squads.firstWhere((s) => s.name == squad.name);

          return Column(
            children: [
              SquadRoleSelectors(squad: updatedSquad),
              Expanded(
                child: ListView.builder(
                  itemCount: updatedSquad.units.length,
                  itemBuilder: (context, index) {
                    final unit = updatedSquad.units[index];
                    return ListTile(
                      title: Text(
                        'Unit: ${unit.name}',
                        style: AppTheme.bodyStyle,
                      ),
                      subtitle: Text(
                        'Chassis: ${unit.chassisType}, TV: ${unit.threatValue}',
                      ),
                      contentPadding: AppTheme.listTilePadding,
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final newUnit = Unit(
                    name: 'New Unit',
                    chassisType: 'Default Chassis',
                    threatValue: 0,
                  );
                  final updatedSquadWithNewUnit = updatedSquad.copyWith(
                    units: List<Unit>.from(updatedSquad.units)..add(newUnit),
                  );
                  context
                      .read<RosterBloc>()
                      .add(UpdateSquad(updatedSquadWithNewUnit));
                },
                child: Text(
                  AppLocalizations.of(context)!.squadAddUnitButtonText,
                  style: AppTheme.buttonTextStyle,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
