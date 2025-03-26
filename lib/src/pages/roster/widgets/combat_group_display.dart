import 'package:flutter/material.dart';
import 'package:gearforce/src/pages/roster/models/combat_group.dart';
import 'package:gearforce/src/theme/app_theme.dart';

class CombatGroupDisplay extends StatelessWidget {
  final List<CombatGroup> combatGroups;

  const CombatGroupDisplay({super.key, required this.combatGroups});

  @override
  Widget build(BuildContext context) {
    if (combatGroups.isEmpty) {
      return Center(
        child: Text(
          'No combat groups available',
          style: AppTheme.subtitleStyle,
        ),
      );
    }

    final display = ListView.builder(
      itemCount: combatGroups.length,
      itemBuilder: (context, index) {
        final combatGroup = combatGroups[index];

        return ExpansionTile(
          title: Text(
            'Combat Group ${index + 1}',
            style: AppTheme.subtitleStyle,
          ),
          children: combatGroup.squads.map((squad) {
            return ExpansionTile(
              title: Text(
                'Squad: ${squad.primaryRole}',
                style: AppTheme.bodyStyle,
              ),
              subtitle: Text(
                'Secondary Role: ${squad.secondaryRole ?? 'None'}',
                style: AppTheme.bodyStyle,
              ),
              children: squad.units.map((unit) {
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
              }).toList(),
            );
          }).toList(),
        );
      },
    );

    return display;
  }
}
