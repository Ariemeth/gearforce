import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/core/theme/app_theme.dart';

String generateUniqueDefaultSquadName(
  BuildContext context,
  List<Squad> squads,
) {
  int squadNumber = squads.length + 1;
  String newSquadName;

  do {
    newSquadName = context.l10n.defaultSquadName(squadNumber);
    squadNumber++;
  } while (squads.any((squad) => squad.name == newSquadName));

  return newSquadName;
}

class AddSquadButton extends StatelessWidget {
  const AddSquadButton({super.key, required this.squads});

  final List<Squad> squads;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final newSquadName = generateUniqueDefaultSquadName(context, squads);

        context.read<RosterBloc>().add(AddNewSquad(name: newSquadName));
      },
      child: Text(
        context.l10n.addSquadButtonText,
        style: AppTheme.buttonTextStyle,
      ),
    );
  }
}
