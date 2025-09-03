import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/pages/roster/widgets/squad_details_screen.dart'
    show SquadDetailsScreen;
import 'package:gearforce/src/theme/app_theme.dart';

class AddSquadButton extends StatelessWidget {
  const AddSquadButton({super.key, required this.squads});

  final List<Squad> squads;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RosterBloc, RosterState>(
      builder: (context, state) {
        return ElevatedButton(
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
            context.read<RosterBloc>().add(AddSquad(squad: newSquad));

            // Navigate to squad details screen automatically
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SquadDetailsScreen(squad: newSquad),
              ),
            );
          },
          child: Text(
            AppLocalizations.of(context)!.addSquadButtonText,
            style: AppTheme.buttonTextStyle,
          ),
        );
      },
    );
  }
}
