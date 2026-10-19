import 'package:gearforce/data/parsers/json/attribute_json_parser.dart';
import 'package:gearforce/data/parsers/weapon_parser.dart';
import 'package:gearforce/data/static/trait_factory.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';
import 'package:gearforce/domain/entities/unit/model_upgrade.dart';
import 'package:gearforce/domain/entities/unit/unit_modifiers.dart';
import 'package:gearforce/domain/entities/unit/upgrade_type.dart';
import 'package:gearforce/domain/modifiers/mod_functions.dart';

class ModelUpgradeJsonParser {
  static ModelUpgrade parseModelUpgrade(Map<String, dynamic> json) {
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
        ? AttributeJsonParser.parseMovement(movementJson)
        : null;

    final rolesJson = json['roles'];
    final parsedRoles = rolesJson is List
        ? rolesJson.whereType<String>().map((roleName) {
            return Role.values.firstWhere(
              (role) =>
                  role.abbreviation.toLowerCase() == roleName.toLowerCase() ||
                  role.name.toLowerCase() == roleName.toLowerCase(),
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
              .expand(
                (weaponCode) => WeaponParser.parseWeaponString(weaponCode),
              )
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

  static int? _asInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return null;
  }
}
