import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/core/widgets/constrained_content.dart';
import 'package:gearforce/core/widgets/unit_attribute_widgets.dart';
import 'package:gearforce/core/widgets/weapon_trait_chips.dart';
import 'package:gearforce/core/widgets/weapon_trait_row.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/model_upgrade.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/squad_upgrade.dart';
import 'package:gearforce/domain/entities/unit/squad_upgrade_model_upgrade_mapper.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec_list_extensions.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/model_info_content.dart';

const double _maxContentWidth = 900;

class ModelDetailsScreen extends StatelessWidget {
  final int squadId;
  final int modelId;

  const ModelDetailsScreen({
    super.key,
    required this.squadId,
    required this.modelId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RosterBloc, RosterState, _ModelLookupResult>(
      selector: (state) {
        for (final squad in state.squads) {
          if (squad.id != squadId) {
            continue;
          }

          for (final model in squad.models) {
            if (model.id == modelId) {
              return _ModelLookupResult(squad: squad, model: model);
            }
          }

          return _ModelLookupResult(squad: squad, model: null);
        }

        return const _ModelLookupResult(squad: null, model: null);
      },
      builder: (context, result) {
        if (result.squad == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Unit Not Found')),
            body: Center(
              child: Text(context.l10n.squadNotFoundMessage(squadId)),
            ),
          );
        }

        final model = result.model;
        if (model == null) {
          return Scaffold(
            appBar: AppBar(title: Text(result.squad!.name)),
            body: const Center(child: Text('No model with this id is found.')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(model.name),
            actions: [
              IconButton(
                tooltip: 'Model Info',
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  _showModelInfoDialog(
                    context: context,
                    model: model,
                    squadName: result.squad!.name,
                  );
                },
              ),
            ],
          ),
          body: ConstrainedContent(
            maxWidth: _maxContentWidth,
            padding: AppTheme.defaultPagePadding,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ModelStatsTable(model: model),
                  const SizedBox(height: 8),
                  WeaponTraitRow(
                    label: context.l10n.reactWeaponsLabel,
                    children: buildWeaponChips(model.weapons.reactWeapons),
                  ),
                  WeaponTraitRow(
                    label: context.l10n.mountedWeaponsLabel,
                    children: buildWeaponChips(model.weapons.mountedWeapons),
                  ),
                  WeaponTraitRow(
                    label: context.l10n.traitsLabel,
                    children: buildTraitChips(model.traits),
                  ),
                  const SizedBox(height: 8),
                  _ModelUpgradesSection(squad: result.squad!, model: model),
                  const SizedBox(height: 8),
                  _SquadUpgradesSection(squad: result.squad!, model: model),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ModelStatsTable extends StatelessWidget {
  final Model model;

  const _ModelStatsTable({required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Stats', style: AppTheme.subtitleStyle),
            const SizedBox(height: 8),
            Table(
              columnWidths: const {
                1: FixedColumnWidth(68),
                2: FixedColumnWidth(66),
                3: FixedColumnWidth(36),
                5: FixedColumnWidth(30),
              },
              defaultColumnWidth: FixedColumnWidth(40),
              children: [
                TableRow(
                  children: [
                    UnitAttributeLabel(context.l10n.attributeTV),
                    UnitAttributeLabel(context.l10n.attributeRoles),
                    UnitAttributeLabel(context.l10n.attributeMove),
                    UnitAttributeLabel(context.l10n.attributeArm),
                    UnitAttributeLabel(context.l10n.attributeHS),
                    UnitAttributeLabel(context.l10n.attributeA),
                    UnitAttributeLabel(context.l10n.attributeGu),
                    UnitAttributeLabel(context.l10n.attributePi),
                    UnitAttributeLabel(context.l10n.attributeEw),
                  ],
                ),
                TableRow(
                  children: [
                    UnitAttributeValue('${model.tv}'),
                    UnitAttributeValue(
                      model.roles.map((r) => r.abbreviation).join(', '),
                    ),
                    UnitAttributeValue(model.movement.toString()),
                    UnitAttributeValue(model.armor.toString()),
                    UnitAttributeValue(model.hullStructure.toString()),
                    UnitAttributeValue(model.actions.toString()),
                    UnitAttributeValue(model.gu.toString()),
                    UnitAttributeValue(model.pi.toString()),
                    UnitAttributeValue(model.ew.toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ModelUpgradesSection extends StatelessWidget {
  final Squad squad;
  final Model model;

  const _ModelUpgradesSection({required this.squad, required this.model});

  @override
  Widget build(BuildContext context) {
    final effectiveModel = model.copyWith(
      availableModelUpgrades: mergeAvailableModelUpgrades(
        squad: squad,
        model: model,
      ),
    );
    final totalUpgrades = effectiveModel.availableModelUpgrades.length;
    final enabledUpgrades = effectiveModel.selectedModelUpgrades.length;

    return Card(
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
        childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        title: Row(
          children: [
            Expanded(
              child: Text('Model Upgrades', style: AppTheme.subtitleStyle),
            ),
            const SizedBox(width: 8),
            Chip(label: Text('$enabledUpgrades / $totalUpgrades enabled')),
          ],
        ),
        children: [
          if (effectiveModel.availableModelUpgrades.isEmpty)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('No model upgrades available.'),
            )
          else
            ...effectiveModel.availableModelUpgrades.map((upgrade) {
              final isEnabled = effectiveModel.hasModelUpgrade(upgrade.id);
              final summary = _buildUpgradeChangeSummary(
                model: effectiveModel,
                upgrade: upgrade,
              );

              final subtitleParts = <String>[
                if (summary.inlineSummary.isNotEmpty) summary.inlineSummary,
                if (upgrade.description.isNotEmpty) upgrade.description,
              ];

              return CheckboxListTile(
                value: isEnabled,
                dense: true,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(upgrade.name),
                subtitle: subtitleParts.isEmpty
                    ? null
                    : Text(subtitleParts.join(' • ')),
                secondary: Tooltip(
                  message: summary.tooltip,
                  waitDuration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.info_outline, size: 18),
                ),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  context.read<RosterBloc>().add(
                    UpdateModelUpgradeEnabled(
                      squad: squad,
                      model: effectiveModel,
                      upgradeId: upgrade.id,
                      enabled: value,
                    ),
                  );
                },
              );
            }),
        ],
      ),
    );
  }
}

class _SquadUpgradesSection extends StatelessWidget {
  final Squad squad;
  final Model model;

  const _SquadUpgradesSection({required this.squad, required this.model});

  @override
  Widget build(BuildContext context) {
    final ruleSet = context.read<RosterBloc>().state.ruleSet;
    final squadUpgradeOptions = ruleSet.availableSquadUpgrades
        .where(
          (upgrade) => upgrade.canApplyToClassification(model.base.classification),
        )
        .toList(growable: false);
    final enabledUpgrades = squadUpgradeOptions
        .where((option) => squad.upgrades.any((selected) => selected.id == option.id))
        .length;

    return Card(
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
        childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        title: Row(
          children: [
            Expanded(
              child: Text('Squad Upgrades', style: AppTheme.subtitleStyle),
            ),
            const SizedBox(width: 8),
            Chip(label: Text('$enabledUpgrades / ${squadUpgradeOptions.length} enabled')),
          ],
        ),
        children: [
          if (squadUpgradeOptions.isEmpty)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('No squad-upgrade options available for this model.'),
            )
          else
            ...squadUpgradeOptions.map((upgrade) {
              final isEnabled = squad.upgrades.any(
                (selected) => selected.id == upgrade.id,
              );
              final columnLabel = upgrade.column == SquadUpgradeColumn.react
                  ? 'React'
                  : 'Mounted';

              return CheckboxListTile(
                value: isEnabled,
                dense: true,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(upgrade.name),
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
    );
  }
}

_UpgradeSummary _buildUpgradeChangeSummary({
  required Model model,
  required ModelUpgrade upgrade,
}) {
  final baseModel = model.hasModelUpgrade(upgrade.id)
      ? model.setModelUpgradeEnabled(upgradeId: upgrade.id, enabled: false)
      : model;
  final upgradedModel = baseModel.setModelUpgradeEnabled(
    upgradeId: upgrade.id,
    enabled: true,
  );

  final tooltipLines = <String>[];
  final inlineParts = <String>[];

  void addNumericDelta(String label, int before, int after) {
    if (before == after) {
      return;
    }

    final delta = after - before;
    final sign = delta > 0 ? '+' : '';
    final short = '$label $sign$delta';
    inlineParts.add(short);
    tooltipLines.add('$label: $before → $after ($sign$delta)');
  }

  void addValueDelta(String label, String before, String after) {
    if (before == after) {
      return;
    }

    inlineParts.add('$label $after');
    tooltipLines.add('$label: $before → $after');
  }

  addNumericDelta('TV', baseModel.tv, upgradedModel.tv);
  addValueDelta(
    'Move',
    baseModel.movement.toString(),
    upgradedModel.movement.toString(),
  );
  addValueDelta(
    'ARM',
    baseModel.armor.toString(),
    upgradedModel.armor.toString(),
  );
  addValueDelta(
    'HS',
    baseModel.hullStructure.toString(),
    upgradedModel.hullStructure.toString(),
  );
  addValueDelta(
    'A',
    baseModel.actions.toString(),
    upgradedModel.actions.toString(),
  );
  addValueDelta('GU', baseModel.gu.toString(), upgradedModel.gu.toString());
  addValueDelta('PI', baseModel.pi.toString(), upgradedModel.pi.toString());
  addValueDelta('EW', baseModel.ew.toString(), upgradedModel.ew.toString());

  final baseTraits = baseModel.traits.map((trait) => trait.name).toSet();
  final upgradedTraits = upgradedModel.traits
      .map((trait) => trait.name)
      .toSet();
  final addedTraits = upgradedTraits.difference(baseTraits).toList()..sort();
  final removedTraits = baseTraits.difference(upgradedTraits).toList()..sort();

  if (addedTraits.isNotEmpty) {
    final added = addedTraits.take(2).join(', ');
    inlineParts.add('+Traits: $added${addedTraits.length > 2 ? ', …' : ''}');
    tooltipLines.add('Added traits: ${addedTraits.join(', ')}');
  }

  if (removedTraits.isNotEmpty) {
    final removed = removedTraits.take(2).join(', ');
    inlineParts.add(
      '-Traits: $removed${removedTraits.length > 2 ? ', …' : ''}',
    );
    tooltipLines.add('Removed traits: ${removedTraits.join(', ')}');
  }

  if (inlineParts.isEmpty) {
    return const _UpgradeSummary(
      inlineSummary: 'No stat changes detected',
      tooltip: 'No stat changes detected for this upgrade.',
    );
  }

  return _UpgradeSummary(
    inlineSummary: inlineParts.take(3).join(' · '),
    tooltip: tooltipLines.join('\n'),
  );
}

class _UpgradeSummary {
  final String inlineSummary;
  final String tooltip;

  const _UpgradeSummary({required this.inlineSummary, required this.tooltip});
}

Future<void> _showModelInfoDialog({
  required BuildContext context,
  required Model model,
  required String squadName,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Model Info'),
        content: SingleChildScrollView(
          child: ModelInfoContent(model: model, squadName: squadName),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

class _ModelLookupResult {
  final Squad? squad;
  final Model? model;

  const _ModelLookupResult({required this.squad, required this.model});
}
