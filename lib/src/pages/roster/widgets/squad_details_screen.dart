import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/generated/i18n/app_localizations.dart';
import 'package:gearforce/src/pages/roster/bloc/roster_bloc.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/pages/roster/widgets/squad_role_selectors.dart';
import 'package:gearforce/src/theme/app_theme.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement_type.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';

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
                  itemCount: updatedSquad.models.length,
                  itemBuilder: (context, index) {
                    final unit = updatedSquad.models[index];
                    return ListTile(
                      title: Text(
                        'Unit: ${unit.name}',
                        style: AppTheme.bodyStyle,
                      ),
                      subtitle: Text(
                        'TV: ${unit.tv}',
                      ),
                      contentPadding: AppTheme.listTilePadding,
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final newUnit = Model(
                    name: 'New Unit',
                    tv: 0,
                    roles: {Role.gp},
                    height: 1.0,
                    movement: Movement([MovementType.walker], 5),
                    armor: Armor(0),
                    hullStructure: HullStructure(hull: 0, structure: 0),
                    actions: UnitActions(0),
                    gu: Skill(0),
                    pi: Skill(0),
                    ew: Skill(0),
                  );
                  final updatedSquadWithNewUnit = updatedSquad.copyWith(
                    models: List<Model>.from(updatedSquad.models)..add(newUnit),
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
