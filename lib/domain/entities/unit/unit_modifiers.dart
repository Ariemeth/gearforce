import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/unit/model_upgrade_context.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';

// Shared typedefs
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

// default implementations
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
}
