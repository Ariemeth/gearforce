import 'package:gearforce/domain/entities/unit/common_modifiers.dart'
    show RequirementCheck, CommonModifiers, NameGenerator;
import 'package:gearforce/domain/entities/unit/unit_modifiers.dart';
import 'package:gearforce/domain/entities/unit/upgrade_option.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_upgrade.g.dart';

@JsonSerializable()
class UnitUpgrade {
  final String _name;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final NameGenerator? nameGenerator;
  final String id;
  final String description;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final StringMod nameMod;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final IntMod tvMod;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final RolesMod rolesMod;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final MovementMod movementMod;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ArmorMod armorMod;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final HullStructureMod hullStructureMod;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final UnitActionsMod actionsMod;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final SkillMod guMod;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final SkillMod piMod;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final SkillMod ewMod;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final WeaponsMod weaponsMod;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TraitsMod traitsMod;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final UpgradeOption? upgradeOption;
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  factory UnitUpgrade.fromJson(Map<String, dynamic> json) =>
      _$UnitUpgradeFromJson(json);

  Map<String, dynamic> toJson() => _$UnitUpgradeToJson(this);

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
