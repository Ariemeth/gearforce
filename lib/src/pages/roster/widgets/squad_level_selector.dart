import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/squad/squad.dart';
import 'package:gearforce/src/models/roster/squad/squad_level.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';

class SquadLevelSelector extends StatelessWidget {
  final Squad squad;
  const SquadLevelSelector({super.key, required this.squad});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Level'),
        SizedBox(width: 5.0),
        DropdownButton<SquadLevel>(
          value: squad.level,
          menuWidth: 90.0,
          items: SquadLevel.values
              .map(
                (lvl) => DropdownMenuItem<SquadLevel>(
                  value: lvl,
                  child: Text(lvl.name),
                ),
              )
              .toList(),
          onChanged: (newLevel) {
            if (newLevel == squad.level || newLevel == null) {
              return;
            }
            context.read<RosterBloc>().add(
              UpdateSquadLevel(squad: squad, level: newLevel),
            );
          },
        ),
      ],
    );
    //return Text(squad?.name ?? 'blah');
  }
}
