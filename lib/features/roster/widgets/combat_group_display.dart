import 'package:flutter/material.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/unit/combat_group.dart';
import 'package:gearforce/core/theme/app_theme.dart';

class CombatGroupDisplay extends StatelessWidget {
  final List<CombatGroup> combatGroups;

  const CombatGroupDisplay({super.key, required this.combatGroups});

  @override
  Widget build(BuildContext context) {
    if (combatGroups.isEmpty) {
      return Center(
        child: Text(
          context.l10n.noCombatGroupsText,
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
            context.l10n.combatGroupTitle(index + 1),
            style: AppTheme.subtitleStyle,
          ),
          children: combatGroup.squads.map((squad) {
            return ExpansionTile(
              title: Text(
                context.l10n.squadRoleLabel(squad.primaryRole.toString()),
                style: AppTheme.bodyStyle,
              ),
              subtitle: Text(
                context.l10n.secondaryRoleLabel(
                  squad.secondaryRole?.toString() ??
                      context.l10n.squadRoleNoneText,
                ),
                style: AppTheme.bodyStyle,
              ),
              children: squad.models.map((unit) {
                return ListTile(
                  title: Text(
                    context.l10n.unitLabel(unit.name),
                    style: AppTheme.bodyStyle,
                  ),
                  subtitle: Text(context.l10n.tvLabel(unit.tv)),
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
