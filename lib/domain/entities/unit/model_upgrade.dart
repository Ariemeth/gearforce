import 'package:gearforce/domain/entities/unit/common_modifiers.dart'
    show RequirementCheck, CommonModifiers, NameGenerator;
import 'package:gearforce/domain/entities/unit/upgrade_type.dart';
import 'package:gearforce/data/static/mod_functions.dart'
    show
        createAddTraitsMod,
        createAddWeaponsMod,
        createHullStructureSetMod,
        createIntAdjustmentMod,
        createSkillAdjustmentMod;
import 'package:gearforce/data/static/trait_factory.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/unit/unit_modifiers.dart';
import 'package:gearforce/domain/entities/unit/upgrade_option.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';
import 'package:gearforce/domain/entities/equipment/weapon_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_upgrade.g.dart';

@JsonSerializable()
class ModelUpgrade {
  final String _name;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final NameGenerator? nameGenerator;
  final String id;
  @JsonKey(fromJson: _upgradeTypeFromJson, toJson: _upgradeTypeToJson)
  final UpgradeType type;
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
    this.requirementCheck = CommonModifiers.defaultRequirementCheck,
  }) : _name = name;

  String get name => nameGenerator?.call() ?? _name;

  factory ModelUpgrade.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final id = json['id'] as String;
    final description = json['description'] as String? ?? '';
    final typeString = json['type'] as String? ?? 'unit';
    final type = UpgradeType.fromString(typeString);

    final tvAdjustment = _asInt(json['tv']);
    final hull = _asInt(json['hull']);
    final structure = _asInt(json['structure']);
    final armor = _asInt(json['armor']);
    final actions = _asInt(json['actions']);
    final gu = _asInt(json['gu']);
    final pi = _asInt(json['pi']);
    final ew = _asInt(json['ew']);

    final movementJson = json['movement'];
    final movement = movementJson is Map<String, dynamic>
        ? Movement.fromJson(movementJson)
        : null;

    final rolesJson = json['roles'];
    final parsedRoles = rolesJson is List
        ? rolesJson.whereType<String>().map((roleName) {
            return Role.values.firstWhere(
              (role) => role.abbreviation == roleName,
            );
          }).toSet()
        : null;

    final traitStrings = (json['traits'] as List?)
        ?.whereType<String>()
        .toList();
    final List<Trait> traitsToAdd = traitStrings == null
        ? <Trait>[]
        : traitStrings.map(TraitFactory.traitFromString).toList();

    final weaponStrings = (json['weapons'] as List?)
        ?.whereType<String>()
        .toList();
    final List<WeaponSpec> weaponsToAdd = weaponStrings == null
        ? <WeaponSpec>[]
        : weaponStrings
              .map((weaponCode) => WeaponParser.parseWeaponString(weaponCode))
              .toList();

    return ModelUpgrade(
      name,
      id: id,
      type: type,
      description: description,
      tvMod: tvAdjustment == null
          ? UnitModifiers.defaultIntMod
          : createIntAdjustmentMod(tvAdjustment),
      rolesMod: parsedRoles == null
          ? UnitModifiers.defaultRolesMod
          : (value, context) => parsedRoles,
      movementMod: movement == null
          ? UnitModifiers.defaultMovementMod
          : (value, context) => movement,
      armorMod: armor == null
          ? UnitModifiers.defaultArmorMod
          : (value, context) => value.copyWith(value: armor),
      hullStructureMod: (hull == null || structure == null)
          ? UnitModifiers.defaultHullStructureMod
          : createHullStructureSetMod(h: hull, s: structure),
      actionsMod: actions == null
          ? UnitModifiers.defaultUnitActionsMod
          : (value, context) => value.copyWith(value: actions),
      guMod: gu == null
          ? UnitModifiers.defaultSkillMod
          : createSkillAdjustmentMod(gu),
      piMod: pi == null
          ? UnitModifiers.defaultSkillMod
          : createSkillAdjustmentMod(pi),
      ewMod: ew == null
          ? UnitModifiers.defaultSkillMod
          : createSkillAdjustmentMod(ew),
      weaponsMod: weaponsToAdd.isEmpty
          ? UnitModifiers.defaultWeaponsMod
          : createAddWeaponsMod(weaponsToAdd),
      traitsMod: traitsToAdd.isEmpty
          ? UnitModifiers.defaultTraitsMod
          : createAddTraitsMod(traitsToAdd),
    );
  }

  Map<String, dynamic> toJson() => _$ModelUpgradeToJson(this);

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
    RequirementCheck? requirementCheck,
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

UpgradeType _upgradeTypeFromJson(dynamic value) {
  if (value == null) {
    return UpgradeType.profile; // default
  }
  return UpgradeType.fromString(value as String);
}

String _upgradeTypeToJson(UpgradeType type) {
  return type.value;
}

int? _asInt(dynamic value) {
  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.toInt();
  }

  return null;
}
