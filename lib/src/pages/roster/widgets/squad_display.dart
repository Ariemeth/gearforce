import 'package:flutter/material.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/pages/roster/models/squad.dart';
import 'package:gearforce/src/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/pages/roster/models/role.dart';
import 'package:gearforce/src/pages/roster/widgets/squad_role_selectors.dart';

class SquadDisplay extends StatelessWidget {
  final List<Squad> squads;

  const SquadDisplay({super.key, required this.squads});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: squads.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.noSquadsText,
                    style: AppTheme.subtitleStyle,
                  ),
                )
              : ListView.builder(
                  itemCount: squads.length,
                  itemBuilder: (context, index) {
                    final squad = squads[index];

                    return ExpansionTile(
                      title: Text(
                        'Squad ${index + 1}', // Display squad name as title
                        style: AppTheme.subtitleStyle,
                      ),
                      children: [
                        SquadRoleSelectors(squad: squad),
                        ...squad.units.map((unit) {
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
                        }),
                      ],
                    );
                  },
                ),
        ),
        ElevatedButton(
          onPressed: () {
            final newSquad = Squad(
              id: DateTime.now().toString(), // Generate a unique ID
              primaryRole: Role.gp, // Default to General Purpose
              secondaryRole: null,
              units: [],
            );
            context.read<RosterBloc>().add(AddSquad(newSquad));
          },
          child: Text(AppLocalizations.of(context)!.addSquadButtonText),
        ),
      ],
    );
  }
}
