import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/pages/roster/models/role.dart';
import 'package:gearforce/src/pages/roster/models/skill_attribute.dart';
import 'package:gearforce/src/pages/roster/models/squad.dart';
import 'package:gearforce/src/pages/roster/models/unit.dart';
import 'package:gearforce/src/pages/roster/widgets/squad_role_selectors.dart';
import 'package:gearforce/src/theme/app_theme.dart';
import 'package:gearforce/src/pages/roster/models/movement.dart';
import 'package:gearforce/src/pages/roster/models/movement_type.dart';
import 'package:gearforce/src/pages/roster/models/armor.dart';
import 'package:gearforce/src/pages/roster/models/hull_structure.dart';
import 'package:gearforce/src/pages/roster/models/model_actions.dart';

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
                    roles: [Role.gp],
                    height: 1.0,
                    movement: Movement(
                      types: [MovementType.walker],
                      value: 5,
                    ),
                    armor: Armor(value: 0),
                    hullStructure: HullStructure(hull: 0, structure: 0),
                    actions: ModelActions(0),
                    gu: SkillAttribute(0),
                    pi: SkillAttribute(0),
                    ew: SkillAttribute(0),
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
