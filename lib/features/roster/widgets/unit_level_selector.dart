import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/attribute/unit_level.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';

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
    return BlocBuilder<RosterCubit, RosterState>(
      builder: (context, state) {
        return Row(
          children: [
            DropdownButton<UnitLevel>(
              value: model.level,
              menuWidth: 90.0,
              items: UnitLevel.values.map((lvl) {
                final canSelect = state.ruleSet.canAssignUnitLevel(
                  model: model,
                  newLevel: lvl,
                  squad: squad,
                  allSquads: state.squads,
                );

                return DropdownMenuItem<UnitLevel>(
                  value: lvl,
                  enabled: canSelect,
                  child: Text(lvl.name),
                );
              }).toList(),
              onChanged: (newLevel) {
                if (newLevel == model.level || newLevel == null) {
                  return;
                }
                context.read<RosterCubit>().updateModelLevel(
                  model: model,
                  squad: squad,
                  level: newLevel,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
