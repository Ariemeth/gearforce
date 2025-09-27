import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/models/roster/unit/attribute/level.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';

class SquadLevelSelector extends StatelessWidget {
  final int squadId;
  const SquadLevelSelector({super.key, required this.squadId});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RosterBloc, RosterState, Squad?>(
      selector: (state) {
        try {
          return state.squads.firstWhere((s) => s.id == squadId);
        } on StateError catch (_, _) {
          log('SquadLevelSelector could not find a squad with id $squadId');
          return null;
        }
      },
      builder: (context, squad) {
        if (squad == null) {
          return SizedBox.shrink();
        }

        return Row(
          children: [
            DropdownButton<Level>(
              value: squad.level,
              menuWidth: 90.0,
              items: Level.values
                  .map(
                    (lvl) => DropdownMenuItem<Level>(
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
      },
    );
  }
}
