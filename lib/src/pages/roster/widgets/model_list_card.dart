import 'package:flutter/material.dart';
import 'package:gearforce/src/models/roster/trait/trait.dart' show Trait;
import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_spec.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_spec_list_extensions.dart';
import 'package:gearforce/src/theme/app_theme.dart';

const double _weaponAndTraitWidth = 134.0;
const SizedBox _weaponAndTraitLabelSpacer = SizedBox(width: 4.0);
const double _attributeLabelFontSize = 14;
const FontWeight _attributeLabelFontWeight = FontWeight.w700;
const double _attributeValueFontSize = 14;
const FontWeight _attributeValueFontWeight = FontWeight.normal;

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
        Table(
          columnWidths: {
            1: const FixedColumnWidth(68.0),
            2: const FixedColumnWidth(66.0),
            3: const FixedColumnWidth(36.0),
            5: const FixedColumnWidth(30.0),
          },
          defaultColumnWidth: const FixedColumnWidth(40),
          children: [
            const TableRow(
              children: [
                _UnitAttributeLabel('TV'),
                _UnitAttributeLabel('Roles'),
                _UnitAttributeLabel('Move'),
                _UnitAttributeLabel('Arm'),
                _UnitAttributeLabel('H/S'),
                _UnitAttributeLabel('A'),
                _UnitAttributeLabel('Gu'),
                _UnitAttributeLabel('Pi'),
                _UnitAttributeLabel('Ew'),
              ],
            ),
            TableRow(
              children: [
                _UnitAttributeValue('${model.tv}'),
                _UnitAttributeValue(
                  model.roles.map((r) => r.abbreviation).join(', '),
                ),
                _UnitAttributeValue(model.movement.toString()),
                _UnitAttributeValue(model.armor.toString()),
                _UnitAttributeValue(model.hullStructure.toString()),
                _UnitAttributeValue(model.actions.toString()),
                _UnitAttributeValue(model.gu.toString()),
                _UnitAttributeValue(model.pi.toString()),
                _UnitAttributeValue(model.ew.toString()),
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
            ..._buildWeaponWidgets(model.weapons.reactWeapons),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: _weaponAndTraitWidth,
              child: _UnitAttributeLabel(
                'Mounted Weapons:',
                textAlign: TextAlign.right,
              ),
            ),
            _weaponAndTraitLabelSpacer,
            ..._buildWeaponWidgets(model.weapons.mountedWeapons),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: _weaponAndTraitWidth,
              child: _UnitAttributeLabel('Traits:', textAlign: TextAlign.right),
            ),
            _weaponAndTraitLabelSpacer,
            ..._buildTraitWidgets(model.traits),
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
        tooltipMessage: weapon.summary,
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
