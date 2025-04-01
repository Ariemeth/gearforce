import 'package:flutter/material.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/pages/roster/widgets/squad_details_screen.dart';

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

                    return ListTile(
                      title: Text(
                        squad.name, // Use name instead of id
                        style: AppTheme.subtitleStyle,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SquadDetailsScreen(squad: squad),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
        ElevatedButton(
          onPressed: () {
            int squadNumber = squads.length + 1;
            String newSquadName;

            // Ensure the squad name is unique
            do {
              newSquadName = 'Squad $squadNumber';
              squadNumber++;
            } while (squads.any((squad) => squad.name == newSquadName));

            final newSquad = Squad(
              name: newSquadName,
              primaryRole: Role.gp,
              secondaryRole: null,
              models: [],
            );
            context.read<RosterBloc>().add(AddSquad(newSquad));
          },
          child: Text(
            AppLocalizations.of(context)!.addSquadButtonText,
            style: AppTheme.buttonTextStyle,
          ),
        ),
      ],
    );
  }
}
