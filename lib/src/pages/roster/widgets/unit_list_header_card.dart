import 'package:flutter/material.dart';
import 'package:gearforce/src/models/roster/trait/trait.dart' show Trait;
import 'package:gearforce/src/models/roster/unit/unit.dart' show Unit;
import 'package:gearforce/src/models/roster/weapon/weapon_spec.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_spec_list_extensions.dart';
import 'package:gearforce/src/theme/app_theme.dart';

const double _weaponAndTraitWidth = 138.0;
const SizedBox _weaponAndTraitLabelSpacer = SizedBox(width: 4.0);
const double _attributeLabelFontSize = 14;
const FontWeight _attributeLabelFontWeight = FontWeight.w700;
const double _attributeValueFontSize = 16;
const FontWeight _attributeValueFontWeight = FontWeight.normal;

class UnitListHeaderCard extends StatelessWidget {
  const UnitListHeaderCard({super.key, required this.unit});

  final Unit unit;

  @override
  Widget build(BuildContext context) {
    return _SmallUnitListHeader(unit: unit);
  }
}

class _SmallUnitListHeader extends StatelessWidget {
  const _SmallUnitListHeader({required this.unit});

  final Unit unit;

  @override
  Widget build(BuildContext context) {
    final reactWeapons = unit.base.weapons.reactWeapons;
    final mountedWeapons = unit.base.weapons.mountedWeapons;
    final traits = unit.base.traits;

    final resultWidget = Column(
      children: [
        Text(unit.name, style: AppTheme.titleStyle),
        Table(
          children: [
            const TableRow(
              children: [
                Center(child: _UnitAttributeLabel('TV')),
                Center(child: _UnitAttributeLabel('Move')),
                Center(child: _UnitAttributeLabel('Arm')),
                Center(child: _UnitAttributeLabel('H/S')),
                Center(child: _UnitAttributeLabel('A')),
                Center(child: _UnitAttributeLabel('Gu')),
                Center(child: _UnitAttributeLabel('Pi')),
                Center(child: _UnitAttributeLabel('Ew')),
              ],
            ),
            TableRow(
              children: [
                Center(child: _UnitAttributeValue('${unit.base.tv}')),
                Center(child: _UnitAttributeValue('${unit.base.movement}')),
                Center(child: _UnitAttributeValue('${unit.base.armor}')),
                Center(
                  child: _UnitAttributeValue('${unit.base.hullStructure}'),
                ),
                Center(child: _UnitAttributeValue('${unit.base.actions}')),
                Center(child: _UnitAttributeValue('${unit.base.gu}')),
                Center(child: _UnitAttributeValue('${unit.base.pi}')),
                Center(child: _UnitAttributeValue('${unit.base.ew}')),
              ],
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: _weaponAndTraitWidth,
              child: _UnitAttributeLabel(
                'React Weapons:',
                textAlign: TextAlign.right,
              ),
            ),
            _weaponAndTraitLabelSpacer,
            ..._buildWeaponWidgets(reactWeapons),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: _weaponAndTraitWidth,
              child: _UnitAttributeLabel(
                'Mounted Weapons',
                textAlign: TextAlign.right,
              ),
            ),
            _weaponAndTraitLabelSpacer,
            ..._buildWeaponWidgets(mountedWeapons),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: _weaponAndTraitWidth,
              child: _UnitAttributeLabel('Traits:', textAlign: TextAlign.right),
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
