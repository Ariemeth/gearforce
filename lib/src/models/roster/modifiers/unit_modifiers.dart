import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/unit/unit_upgrade_context.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_spec.dart';

// Shared typedefs
typedef StringMod = String Function(String, UnitUpgradeContext);
typedef IntMod = int Function(int, UnitUpgradeContext);
typedef RolesMod = Set<Role> Function(Set<Role>, UnitUpgradeContext);
typedef MovementMod = Movement Function(Movement, UnitUpgradeContext);
typedef ArmorMod = Armor Function(Armor, UnitUpgradeContext);
typedef HullStructureMod =
    HullStructure Function(HullStructure, UnitUpgradeContext);
typedef UnitActionsMod = UnitActions Function(UnitActions, UnitUpgradeContext);
typedef SkillMod = Skill Function(Skill, UnitUpgradeContext);
typedef WeaponsMod =
    List<WeaponSpec> Function(List<WeaponSpec>, UnitUpgradeContext);
typedef TraitsMod = List<Trait> Function(List<Trait>, UnitUpgradeContext);

// default implementations
class UnitModifiers {
  static String defaultStringMod(String value, UnitUpgradeContext context) =>
      value;
  static int defaultIntMod(int value, UnitUpgradeContext context) => value;
  static Set<Role> defaultRolesMod(
    Set<Role> value,
    UnitUpgradeContext context,
  ) => value;
  static Movement defaultMovementMod(
    Movement value,
    UnitUpgradeContext context,
  ) => value;
  static Armor defaultArmorMod(Armor value, UnitUpgradeContext context) =>
      value;
  static HullStructure defaultHullStructureMod(
    HullStructure value,
    UnitUpgradeContext context,
  ) => value;
  static UnitActions defaultUnitActionsMod(
    UnitActions value,
    UnitUpgradeContext context,
  ) => value;
  static Skill defaultSkillMod(Skill value, UnitUpgradeContext context) =>
      value;
  static List<WeaponSpec> defaultWeaponsMod(
    List<WeaponSpec> value,
    UnitUpgradeContext context,
  ) => value;
  static List<Trait> defaultTraitsMod(
    List<Trait> value,
    UnitUpgradeContext context,
  ) => value;
}
