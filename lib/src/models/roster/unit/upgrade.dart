import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/upgrade_context.dart';
import 'package:gearforce/src/models/roster/unit/upgrade_option.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/weapon/weapon.dart';

typedef StringMod = String Function(String, UpgradeContext);
typedef IntMod = int Function(int, UpgradeContext);
typedef RolesMod = Set<Role> Function(Set<Role>, UpgradeContext);
typedef MovementMod = Movement Function(Movement, UpgradeContext);
typedef ArmorMod = Armor Function(Armor, UpgradeContext);
typedef HullStructureMod = HullStructure Function(
    HullStructure, UpgradeContext);
typedef UnitActionsMod = UnitActions Function(UnitActions, UpgradeContext);
typedef SkillMod = Skill Function(Skill, UpgradeContext);
typedef WeaponsMod = List<Weapon> Function(List<Weapon>, UpgradeContext);
typedef TraitsMod = List<Trait> Function(List<Trait>, UpgradeContext);
typedef NameGenerator = String Function();

class Upgrade {
  final String _name;
  final NameGenerator? nameGenerator;
  final String id;
  final String description;
  final StringMod nameMod;
  final IntMod tvMod;
  final RolesMod rolesMod;
  final MovementMod movementMod;
  final ArmorMod armorMod;
  final HullStructureMod hullStructureMod;
  final UnitActionsMod actionsMod;
  final SkillMod guMod;
  final SkillMod piMod;
  final SkillMod ewMod;
  final WeaponsMod weaponsMod;
  final TraitsMod traitsMod;
  final UpgradeOption? upgradeOption;

  const Upgrade(
    String name, {
    required this.id,
    this.nameGenerator,
    this.description = '',
    this.nameMod = _defaultStringMod,
    this.tvMod = _defaultIntMod,
    this.rolesMod = _defaultRolesMod,
    this.movementMod = _defaultMovementMod,
    this.armorMod = _defaultArmorMod,
    this.hullStructureMod = _defaultHullStructureMod,
    this.actionsMod = _defaultUnitActionsMod,
    this.guMod = _defaultSkillMod,
    this.piMod = _defaultSkillMod,
    this.ewMod = _defaultSkillMod,
    this.weaponsMod = _defaultWeaponsMod,
    this.traitsMod = _defaultTraitsMod,
    this.upgradeOption,
  }) : _name = name;

  String get name => nameGenerator?.call() ?? _name;

  Upgrade copyWith({
    String? name,
    NameGenerator? nameGenerator,
    String? id,
    String? description,
    StringMod? nameMod,
    IntMod? tvMod,
    RolesMod? rolesMod,
    MovementMod? movementMod,
    ArmorMod? armorMod,
    HullStructureMod? hullStructureMod,
    UnitActionsMod? actionsMod,
    SkillMod? guMod,
    SkillMod? piMod,
    SkillMod? ewMod,
    WeaponsMod? weaponsMod,
    TraitsMod? traitsMod,
    UpgradeOption? upgradeOption,
    bool replaceModOption = false,
  }) {
    return Upgrade(
      name ?? this.name,
      id: id ?? this.id,
      nameGenerator: nameGenerator ?? this.nameGenerator,
      description: description ?? this.description,
      nameMod: nameMod ?? this.nameMod,
      tvMod: tvMod ?? this.tvMod,
      rolesMod: rolesMod ?? this.rolesMod,
      movementMod: movementMod ?? this.movementMod,
      armorMod: armorMod ?? this.armorMod,
      hullStructureMod: hullStructureMod ?? this.hullStructureMod,
      actionsMod: actionsMod ?? this.actionsMod,
      guMod: guMod ?? this.guMod,
      piMod: piMod ?? this.piMod,
      ewMod: ewMod ?? this.ewMod,
      weaponsMod: weaponsMod ?? this.weaponsMod,
      traitsMod: traitsMod ?? this.traitsMod,
      upgradeOption: replaceModOption
          ? upgradeOption
          : (upgradeOption ?? this.upgradeOption),
    );
  }

  static String _defaultStringMod(String value, UpgradeContext context) =>
      value;
  static int _defaultIntMod(int value, UpgradeContext context) => value;
  static Set<Role> _defaultRolesMod(Set<Role> value, UpgradeContext context) =>
      value;
  static Movement _defaultMovementMod(Movement value, UpgradeContext context) =>
      value;
  static Armor _defaultArmorMod(Armor value, UpgradeContext context) => value;
  static HullStructure _defaultHullStructureMod(
          HullStructure value, UpgradeContext context) =>
      value;
  static UnitActions _defaultUnitActionsMod(
          UnitActions value, UpgradeContext context) =>
      value;
  static Skill _defaultSkillMod(Skill value, UpgradeContext context) => value;
  static List<Weapon> _defaultWeaponsMod(
          List<Weapon> value, UpgradeContext context) =>
      value;
  static List<Trait> _defaultTraitsMod(
          List<Trait> value, UpgradeContext context) =>
      value;
}
