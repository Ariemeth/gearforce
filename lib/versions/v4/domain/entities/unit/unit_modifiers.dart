import 'package:gearforce/versions/v4/domain/entities/attribute/armor.dart';
import 'package:gearforce/versions/v4/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/versions/v4/domain/entities/attribute/movement.dart';
import 'package:gearforce/versions/v4/domain/entities/attribute/role.dart';
import 'package:gearforce/versions/v4/domain/entities/attribute/skill.dart';
import 'package:gearforce/versions/v4/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/versions/v4/domain/entities/equipment/trait.dart';
import 'package:gearforce/versions/v4/domain/entities/equipment/weapon_spec.dart';
import 'package:gearforce/versions/v4/domain/entities/unit/model_upgrade_context.dart';

typedef StringMod = String Function(String, ModelUpgradeContext);
typedef IntMod = int Function(int, ModelUpgradeContext);
typedef RolesMod = Set<Role> Function(Set<Role>, ModelUpgradeContext);
typedef MovementMod = Movement Function(Movement, ModelUpgradeContext);
typedef ArmorMod = Armor Function(Armor, ModelUpgradeContext);
typedef HullStructureMod =
    HullStructure Function(HullStructure, ModelUpgradeContext);
typedef UnitActionsMod = UnitActions Function(UnitActions, ModelUpgradeContext);
typedef SkillMod = Skill Function(Skill, ModelUpgradeContext);
typedef WeaponsMod =
    List<WeaponSpec> Function(List<WeaponSpec>, ModelUpgradeContext);
typedef TraitsMod = List<Trait> Function(List<Trait>, ModelUpgradeContext);

class UnitModifiers {
  static String defaultStringMod(String value, ModelUpgradeContext context) =>
      value;
  static int defaultIntMod(int value, ModelUpgradeContext context) => value;
  static Set<Role> defaultRolesMod(
    Set<Role> value,
    ModelUpgradeContext context,
  ) => value;
  static Movement defaultMovementMod(
    Movement value,
    ModelUpgradeContext context,
  ) => value;
  static Armor defaultArmorMod(Armor value, ModelUpgradeContext context) =>
      value;
  static HullStructure defaultHullStructureMod(
    HullStructure value,
    ModelUpgradeContext context,
  ) => value;
  static UnitActions defaultUnitActionsMod(
    UnitActions value,
    ModelUpgradeContext context,
  ) => value;
  static Skill defaultSkillMod(Skill value, ModelUpgradeContext context) =>
      value;
  static List<WeaponSpec> defaultWeaponsMod(
    List<WeaponSpec> value,
    ModelUpgradeContext context,
  ) => value;
  static List<Trait> defaultTraitsMod(
    List<Trait> value,
    ModelUpgradeContext context,
  ) => value;

  /// Mod function to adjust an integer value (e.g., TV).
  static IntMod adjustInt(int adjustment) {
    return (value, context) => value + adjustment;
  }

  /// Mod function to set specific hull and structure values.
  static HullStructureMod setHullStructure({required int h, required int s}) {
    return (hullStructure, context) =>
        hullStructure.copyWith(hull: h, structure: s);
  }

  /// Mod function to set a skill value (e.g., GU, PI, EW).
  static SkillMod setSkill(int newValue) {
    return (skill, context) => skill.copyWith(value: newValue);
  }

  /// Mod function to add traits to a list.
  static TraitsMod addTraits(List<Trait> traitsToAdd) {
    return (traits, context) => [...traits, ...traitsToAdd];
  }

  /// Mod function to add weapons to a list.
  static WeaponsMod addWeapons(List<WeaponSpec> weaponsToAdd) {
    return (weapons, context) => [...weapons, ...weaponsToAdd];
  }

  /// Mod function to swap weapons (remove specified codes and add new specs).
  static WeaponsMod swapWeapons({
    List<String> removeWeaponCodes = const [],
    List<WeaponSpec> defaultWeaponsToAdd = const [],
    Map<String, List<WeaponSpec>>? optionWeaponsMap,
  }) {
    return (weapons, context) {
      var result = List<WeaponSpec>.from(weapons);

      if (removeWeaponCodes.isNotEmpty) {
        for (final removeCode in removeWeaponCodes) {
          final cleanCode = removeCode.trim().toUpperCase();
          final index = result.indexWhere((spec) {
            if (spec.code.toUpperCase() == cleanCode) return true;
            return spec.weapons.any((w) => w.code.toUpperCase() == cleanCode);
          });
          if (index != -1) {
            result.removeAt(index);
          }
        }
      }

      List<WeaponSpec> weaponsToAdd = defaultWeaponsToAdd;
      if (optionWeaponsMap != null && context.upgrade.upgradeOption != null) {
        final selected = context.upgrade.upgradeOption!.selectedOption;
        if (selected != null && optionWeaponsMap.containsKey(selected)) {
          weaponsToAdd = optionWeaponsMap[selected]!;
        } else if (optionWeaponsMap.isNotEmpty) {
          weaponsToAdd = optionWeaponsMap.values.first;
        }
      }

      return [...result, ...weaponsToAdd];
    };
  }
}
