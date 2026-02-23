import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/generated/i18n/app_localizations.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/core/theme/app_theme.dart';

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

            context.read<RosterBloc>().add(AddNewSquad(name: newSquadName));
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
