import 'package:material_ui/material_ui.dart';
import 'package:gearforce/core/widgets/unit_attribute_widgets.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart' show Trait;
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';

/// Builds a list of comma-separated [UnitAttributeValue] chips for weapons.
///
/// When [showTooltip] is true (the default), each chip shows
/// [WeaponSpec.summary] as a tooltip on hover.
List<Widget> buildWeaponChips(
  List<WeaponSpec> weapons, {
  bool showTooltip = true,
}) {
  return weapons.asMap().entries.map((entry) {
    final index = entry.key;
    final weapon = entry.value;
    final isLast = index == weapons.length - 1;
    return UnitAttributeValue(
      isLast ? weapon.code : '${weapon.code}, ',
      textAlign: TextAlign.left,
      tooltipMessage: showTooltip ? weapon.summary : null,
    );
  }).toList();
}

/// Builds a list of comma-separated [UnitAttributeValue] chips for traits.
///
/// Each chip shows [Trait.description] as a tooltip on hover.
List<Widget> buildTraitChips(List<Trait> traits) {
  return traits.asMap().entries.map((entry) {
    final index = entry.key;
    final trait = entry.value;
    final isLast = index == traits.length - 1;
    final traitText = trait.toString();
    return UnitAttributeValue(
      isLast ? traitText : '$traitText, ',
      tooltipMessage: trait.description,
      textAlign: TextAlign.left,
    );
  }).toList();
}
