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

const double _weaponAndTraitWidth = 134.0;
const SizedBox _weaponAndTraitLabelSpacer = SizedBox(width: 4.0);
const double _attributeLabelFontSize = 14;
const FontWeight _attributeLabelFontWeight = FontWeight.w700;
const double _attributeValueFontSize = 14;
const FontWeight _attributeValueFontWeight = FontWeight.normal;

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
                _UnitAttributeLabel(context.l10n.attributeTV),
                _UnitAttributeLabel(context.l10n.attributeMove),
                _UnitAttributeLabel(context.l10n.attributeArm),
                _UnitAttributeLabel(context.l10n.attributeHS),
                _UnitAttributeLabel(context.l10n.attributeA),
                _UnitAttributeLabel(context.l10n.attributeGu),
                _UnitAttributeLabel(context.l10n.attributePi),
                _UnitAttributeLabel(context.l10n.attributeEw),
              ],
            ),
            TableRow(
              children: [
                _UnitAttributeValue('$tv'),
                _UnitAttributeValue('${movement ?? '-'}'),
                _UnitAttributeValue('${arm ?? '-'}'),
                _UnitAttributeValue('${hullStructure ?? '-'}'),
                _UnitAttributeValue('${actions ?? '-'}'),
                _UnitAttributeValue('${gu ?? '-'}'),
                _UnitAttributeValue('${pi ?? '-'}'),
                _UnitAttributeValue('${ew ?? '-'}'),
              ],
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: _weaponAndTraitWidth,
              child: _UnitAttributeLabel(
                context.l10n.reactWeaponsLabel,
                textAlign: TextAlign.right,
              ),
            ),
            _weaponAndTraitLabelSpacer,
            ..._buildWeaponWidgets(reactWeapons),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: _weaponAndTraitWidth,
              child: _UnitAttributeLabel(
                context.l10n.mountedWeaponsLabel,
                textAlign: TextAlign.right,
              ),
            ),
            _weaponAndTraitLabelSpacer,
            ..._buildWeaponWidgets(mountedWeapons),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: _weaponAndTraitWidth,
              child: _UnitAttributeLabel(
                context.l10n.traitsLabel,
                textAlign: TextAlign.right,
              ),
            ),
            _weaponAndTraitLabelSpacer,
            ..._buildTraitWidgets(traits),
          ],
        ),
      ],
    );

    return resultWidget;
  }

  List<Widget> _buildWeaponWidgets(List<WeaponSpec> weapons) {
    return weapons.asMap().entries.map((entry) {
      final index = entry.key;
      final weapon = entry.value;
      final isLast = index == weapons.length - 1;
      return _UnitAttributeValue(
        isLast ? weapon.code : '${weapon.code}, ',
        textAlign: TextAlign.left,
      );
    }).toList();
  }

  List<Widget> _buildTraitWidgets(List<Trait> traits) {
    return traits.asMap().entries.map((entry) {
      final index = entry.key;
      final trait = entry.value;
      final isLast = index == traits.length - 1;
      return _UnitAttributeValue(
        isLast ? trait.name : '${trait.name}, ',
        tooltipMessage: trait.description,
        textAlign: TextAlign.left,
      );
    }).toList();
  }
}

class _UnitAttributeLabel extends StatelessWidget {
  const _UnitAttributeLabel(
    this.labelText, {
    this.textAlign = TextAlign.center,
  });

  final String labelText;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: _attributeLabelFontSize,
        fontWeight: _attributeLabelFontWeight,
      ),
    );
  }
}

class _UnitAttributeValue extends StatelessWidget {
  const _UnitAttributeValue(
    this.labelText, {
    this.textAlign = TextAlign.center,
    this.tooltipMessage,
  });

  final String labelText;
  final TextAlign textAlign;
  final String? tooltipMessage;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      labelText,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: _attributeValueFontSize,
        fontWeight: _attributeValueFontWeight,
      ),
    );

    return tooltipMessage == null
        ? textWidget
        : Tooltip(message: tooltipMessage, child: textWidget);
  }
}
