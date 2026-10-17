import 'dart:developer';
import 'package:gearforce/domain/entities/unit/model_upgrade_context.dart';
import 'package:gearforce/domain/entities/equipment/weapon_parser.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';

typedef WeaponsMod =
    List<WeaponSpec> Function(List<WeaponSpec>, ModelUpgradeContext);
typedef IntMod = int Function(int, ModelUpgradeContext);
typedef HullStructureMod =
    HullStructure Function(HullStructure, ModelUpgradeContext);
typedef SkillMod = Skill Function(Skill, ModelUpgradeContext);
typedef TraitsMod = List<Trait> Function(List<Trait>, ModelUpgradeContext);

/// Mod function to swap weapons based on upgrade options.
WeaponsMod createSwapWeaponsFromOptionsMod(
  String oldWeaponCode,
  bool hasReact,
) {
  return (weapons, context) {
    if (!weapons.any((w) => w.code == oldWeaponCode) ||
        context.upgrade.upgradeOption == null) {
      return weapons;
    }

    final newWeaponCode = context.upgrade.upgradeOption!.selectedOption!;

    try {
      final newWeapon = WeaponParser.parseWeaponString(
        newWeaponCode,
        hasReact: hasReact,
      );

      final index = weapons.indexWhere((w) => w.code == oldWeaponCode);
      final updatedWeapons = List<WeaponSpec>.from(weapons);
      updatedWeapons[index] = newWeapon;
      return updatedWeapons;
    } catch (e, stackTrace) {
      log(
        'Failed to parse weapon string "$newWeaponCode": $e',
        error: e,
        stackTrace: stackTrace,
      );
      return weapons; // Return original weapons if parsing fails
    }
  };
}

/// Mod function to adjust an integer value (e.g., TV).
IntMod createIntAdjustmentMod(int adjustment) {
  return (value, context) => value + adjustment;
}

/// Mod function to set specific hull and structure values.
HullStructureMod createHullStructureSetMod({required int h, required int s}) {
  return (hullStructure, context) =>
      hullStructure.copyWith(hull: h, structure: s);
}

/// Mod function to adjust a skill value.
SkillMod createSkillAdjustmentMod(int newValue) {
  return (skill, context) => skill.copyWith(value: newValue);
}

/// Mod function to add traits to a list.
TraitsMod createAddTraitsMod(List<Trait> traitsToAdd) {
  return (traits, context) => [...traits, ...traitsToAdd];
}

/// Mod function to add weapons to a list.
WeaponsMod createAddWeaponsMod(List<WeaponSpec> weaponsToAdd) {
  return (weapons, context) => [...weapons, ...weaponsToAdd];
}
