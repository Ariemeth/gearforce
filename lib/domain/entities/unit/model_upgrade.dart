import 'package:gearforce/domain/entities/unit/common_modifiers.dart'
    show CommonModifiers, ModelRequirementCheck, NameGenerator;
import 'package:gearforce/domain/entities/unit/unit_modifiers.dart';
import 'package:gearforce/domain/entities/unit/upgrade_option.dart';
import 'package:gearforce/domain/entities/unit/upgrade_type.dart';

class ModelUpgrade {
  final String _name;
  final NameGenerator? nameGenerator;
  final String id;
  final UpgradeType type;
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
  final ModelRequirementCheck requirementCheck;

  const ModelUpgrade(
    String name, {
    required this.id,
    required this.type,
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
    this.requirementCheck = CommonModifiers.defaultModelRequirementCheck,
  }) : _name = name;

  String get name => nameGenerator?.call() ?? _name;

  ModelUpgrade copyWith({
    String? name,
    NameGenerator? nameGenerator,
    String? id,
    UpgradeType? type,
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
    ModelRequirementCheck? requirementCheck,
  }) {
    return ModelUpgrade(
      name ?? this.name,
      id: id ?? this.id,
      type: type ?? this.type,
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
