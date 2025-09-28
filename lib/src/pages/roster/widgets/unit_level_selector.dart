import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/squad/squad.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_level.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';

class UnitLevelSelector extends StatelessWidget {
  final Model model;
  final Squad squad;
  const UnitLevelSelector({
    super.key,
    required this.squad,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<UnitLevel>(
          value: model.level,
          menuWidth: 90.0,
          items: UnitLevel.values
              .map(
                (lvl) => DropdownMenuItem<UnitLevel>(
                  value: lvl,
                  child: Text(lvl.name),
                ),
              )
              .toList(),
          onChanged: (newLevel) {
            if (newLevel == model.level || newLevel == null) {
              return;
            }
            context.read<RosterBloc>().add(
              UpdateModelLevel(model: model, squad: squad, level: newLevel),
            );
          },
        ),
      ],
    );
    //return Text(squad?.name ?? 'blah');
  }
}
