import 'package:material_ui/material_ui.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec_list_extensions.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/widgets/unit_attribute_widgets.dart';
import 'package:gearforce/core/widgets/weapon_trait_row.dart';
import 'package:gearforce/core/widgets/weapon_trait_chips.dart';

const double _rolesAttributeWidth = 68.0;
const double _moveAttributeWidth = 66.0;
const double _armorAttributeWidth = 36.0;
const double _actionsAttributeWidth = 30.0;

class ModelListCard extends StatelessWidget {
  final Model model;

  const ModelListCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return _SmallUnitListHeader(model);
  }
}

class _SmallUnitListHeader extends StatelessWidget {
  const _SmallUnitListHeader(this.model);

  final Model model;

  @override
  Widget build(BuildContext context) {
    final resultWidget = Column(
      children: [
        Text(model.name, style: AppTheme.titleStyle),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              columnWidths: {
                1: const FixedColumnWidth(_rolesAttributeWidth),
                2: const FixedColumnWidth(_moveAttributeWidth),
                3: const FixedColumnWidth(_armorAttributeWidth),
                5: const FixedColumnWidth(_actionsAttributeWidth),
              },
              defaultColumnWidth: const FixedColumnWidth(40),
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
      ],
    );

    return resultWidget;
  }
}
