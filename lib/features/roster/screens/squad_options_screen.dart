import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/widgets/constrained_content.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';

const double _maxContentWidth = 900;

class SquadOptionsScreen extends StatelessWidget {
  final int squadId;

  const SquadOptionsScreen({super.key, required this.squadId});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RosterBloc, RosterState, Squad?>(
      selector: (state) {
        for (final squad in state.squads) {
          if (squad.id == squadId) {
            return squad;
          }
        }
        return null;
      },
      builder: (context, squad) {
        if (squad == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Squad Options')),
            body: const Center(child: Text('Squad not found.')),
          );
        }

        final ruleSet = context.read<RosterBloc>().state.ruleSet;
        final allOptions = ruleSet.availableSquadUpgrades;

        return Scaffold(
          appBar: AppBar(title: Text('${squad.name} Options')),
          body: ConstrainedContent(
            maxWidth: _maxContentWidth,
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                const Text(
                  'Select squad upgrades to make available for this squad.',
                ),
                const SizedBox(height: 8),
                ...allOptions.map((upgrade) {
                  final isSelected = squad.upgrades.any(
                    (selected) => selected.id == upgrade.id,
                  );
                  final columnLabel = upgrade.column.name == 'react'
                      ? 'React'
                      : 'Mounted';

                  return CheckboxListTile(
                    value: isSelected,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text('${upgrade.name} (+${upgrade.tv} TV)'),
                    subtitle: Text(
                      '${upgrade.weaponCode} • $columnLabel Column • ${upgrade.description}',
                    ),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }

                      context.read<RosterBloc>().add(
                        UpdateSquadUpgradeEnabled(
                          squad: squad,
                          upgradeId: upgrade.id,
                          enabled: value,
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}