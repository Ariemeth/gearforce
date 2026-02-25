import 'package:flutter/material.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart' show Trait;
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec_list_extensions.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/widgets/unit_attribute_widgets.dart';
import 'package:gearforce/core/widgets/weapon_trait_row.dart';
import 'package:gearforce/core/widgets/weapon_trait_chips.dart';

class UnitListCard extends StatelessWidget {
  UnitListCard.header({super.key, required Unit unit})
    : name = unit.name,
      tv = unit.base.tv,
      movement = unit.base.movement,
      arm = unit.base.armor,
      hullStructure = unit.base.hullStructure,
      actions = unit.base.actions,
      gu = unit.base.gu,
      pi = unit.base.pi,
      ew = unit.base.ew,
      weapons = unit.base.weapons,
      traits = unit.base.traits;

  UnitListCard.variant({super.key, required Variant variant})
    : name = variant.name,
      tv = variant.tv,
      movement = variant.movement,
      arm = variant.armor,
      hullStructure = variant.hullStructure,
      actions = variant.actions,
      gu = variant.gu,
      pi = variant.pi,
      ew = variant.ew,
      weapons = variant.weapons ?? const [],
      traits = variant.traits ?? const [];

  final String name;
  final int tv;
  final Movement? movement;
  final Armor? arm;
  final HullStructure? hullStructure;
  final UnitActions? actions;
  final Skill? gu;
  final Skill? pi;
  final Skill? ew;
  final List<WeaponSpec> weapons;
  final List<Trait> traits;

  @override
  Widget build(BuildContext context) {
    return _SmallUnitListHeader(
      name: name,
      tv: tv,
      movement: movement,
      arm: arm,
      hullStructure: hullStructure,
      actions: actions,
      gu: gu,
      pi: pi,
      ew: ew,
      weapons: weapons,
      traits: traits,
    );
  }
}

class _SmallUnitListHeader extends StatelessWidget {
  _SmallUnitListHeader({
    required this.name,
    required this.tv,
    this.movement,
    this.arm,
    this.hullStructure,
    this.actions,
    this.gu,
    this.pi,
    this.ew,
    List<WeaponSpec> weapons = const [],
    this.traits = const [],
  }) : reactWeapons = weapons.reactWeapons,
       mountedWeapons = weapons.mountedWeapons;

  final String name;
  final int tv;
  final Movement? movement;
  final Armor? arm;
  final HullStructure? hullStructure;
  final UnitActions? actions;
  final Skill? gu;
  final Skill? pi;
  final Skill? ew;
  final List<WeaponSpec> reactWeapons;
  final List<WeaponSpec> mountedWeapons;
  final List<Trait> traits;

  @override
  Widget build(BuildContext context) {
    final resultWidget = Column(
      children: [
        Text(name, style: AppTheme.titleStyle),
        Table(
          columnWidths: {1: const FixedColumnWidth(65.0)},
          defaultColumnWidth: const FixedColumnWidth(40),
          children: [
            TableRow(
              children: [
                UnitAttributeLabel(context.l10n.attributeTV),
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
                UnitAttributeValue('$tv'),
                UnitAttributeValue('${movement ?? '-'}'),
                UnitAttributeValue('${arm ?? '-'}'),
                UnitAttributeValue('${hullStructure ?? '-'}'),
                UnitAttributeValue('${actions ?? '-'}'),
                UnitAttributeValue('${gu ?? '-'}'),
                UnitAttributeValue('${pi ?? '-'}'),
                UnitAttributeValue('${ew ?? '-'}'),
              ],
            ),
          ],
        ),
        WeaponTraitRow(
          label: context.l10n.reactWeaponsLabel,
          children: buildWeaponChips(reactWeapons, showTooltip: false),
        ),
        WeaponTraitRow(
          label: context.l10n.mountedWeaponsLabel,
          children: buildWeaponChips(mountedWeapons, showTooltip: false),
        ),
        WeaponTraitRow(
          label: context.l10n.traitsLabel,
          children: buildTraitChips(traits),
        ),
      ],
    );

    return resultWidget;
  }
}
