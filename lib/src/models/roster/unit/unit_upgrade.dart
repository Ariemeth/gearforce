import 'package:gearforce/src/models/roster/modifiers/common_modifiers.dart'
    show RequirementCheck, CommonModifiers, NameGenerator;
import 'package:gearforce/src/models/roster/modifiers/unit_modifiers.dart';
import 'package:gearforce/src/models/roster/unit/upgrade_option.dart';

class UnitUpgrade {
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
  final RequirementCheck requirementCheck;

  const UnitUpgrade(
    String name, {
    required this.id,
    this.nameGenerator,
    this.description = '',
    this.nameMod = UnitModifiers.defaultStringMod,
    this.tvMod = UnitModifiers.defaultIntMod,
    this.rolesMod = UnitModifiers.defaultRolesMod,
    this.movementMod = UnitModifiers.defaultMovementMod,
    this.armorMod = UnitModifiers.defaultArmorMod,
    this.hullStructureMod = UnitModifiers.defaultHullStructureMod,
    this.actionsMod = UnitModifiers.defaultUnitActionsMod,
    this.guMod = UnitModifiers.defaultSkillMod,
    this.piMod = UnitModifiers.defaultSkillMod,
    this.ewMod = UnitModifiers.defaultSkillMod,
    this.weaponsMod = UnitModifiers.defaultWeaponsMod,
    this.traitsMod = UnitModifiers.defaultTraitsMod,
    this.upgradeOption,
    this.requirementCheck = CommonModifiers.defaultRequirementCheck,
  }) : _name = name;

  String get name => nameGenerator?.call() ?? _name;

  UnitUpgrade copyWith({
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
    RequirementCheck? requirementCheck,
  }) {
    return UnitUpgrade(
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
      requirementCheck: requirementCheck ?? this.requirementCheck,
    );
  }
}
