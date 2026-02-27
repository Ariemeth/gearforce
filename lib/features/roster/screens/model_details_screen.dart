import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/core/widgets/constrained_content.dart';
import 'package:gearforce/core/widgets/unit_attribute_widgets.dart';
import 'package:gearforce/core/widgets/weapon_trait_chips.dart';
import 'package:gearforce/core/widgets/weapon_trait_row.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
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
