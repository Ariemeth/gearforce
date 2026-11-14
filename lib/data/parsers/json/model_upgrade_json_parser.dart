import 'package:gearforce/data/parsers/json/attribute_json_parser.dart';
import 'package:gearforce/data/parsers/weapon_parser.dart';
import 'package:gearforce/data/static/trait_factory.dart';
import 'package:gearforce/domain/entities/attribute/model_attribute.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';
import 'package:gearforce/domain/entities/unit/model_upgrade.dart';
import 'package:gearforce/domain/entities/unit/unit_modifiers.dart';
import 'package:gearforce/domain/entities/unit/upgrade_option.dart';
import 'package:gearforce/domain/entities/unit/upgrade_type.dart';

class ModelUpgradeJsonParser {
  static ModelUpgrade parseModelUpgrade(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final id = json['id'] as String;
    final description = json['description'] as String? ?? '';
    final typeString = json['type'] as String? ?? 'unit';
    final type = UpgradeType.fromString(typeString);
    final isReact = json['isReact'] as bool? ?? false;

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

    final removeWeaponStrings =
        (json['removeWeapons'] as List?)?.whereType<String>().toList() ??
        const <String>[];

    final weaponStrings = (json['weapons'] as List?)
        ?.whereType<String>()
        .toList();
    final List<WeaponSpec> defaultWeaponsToAdd = weaponStrings == null
        ? <WeaponSpec>[]
        : weaponStrings
              .expand(
                (weaponCode) => WeaponParser.parseWeaponString(
                  weaponCode,
                  hasReact: isReact,
                ),
              )
              .toList();

    Map<String, List<WeaponSpec>>? optionWeaponsMap;
    UpgradeOption? upgradeOption;

    final optionsJson = json['options'] as List?;
    if (optionsJson != null && optionsJson.isNotEmpty) {
      optionWeaponsMap = {};
      final optionNames = <String>[];
      for (final optObj in optionsJson.whereType<Map<String, dynamic>>()) {
        final optName = optObj['name'] as String;
        optionNames.add(optName);
        final optWeapons = (optObj['weapons'] as List?)
            ?.whereType<String>()
            .toList();
        if (optWeapons != null && optWeapons.isNotEmpty) {
          optionWeaponsMap[optName] = optWeapons
              .expand(
                (weaponCode) => WeaponParser.parseWeaponString(
                  weaponCode,
                  hasReact: isReact,
                ),
              )
              .toList();
        }
      }

      if (optionNames.isNotEmpty) {
        upgradeOption = UpgradeOption(
          optionsGenerator: () => optionNames,
          selectedOption: optionNames.first,
        );
      }
    }

    final hasWeaponMods =
        removeWeaponStrings.isNotEmpty ||
        defaultWeaponsToAdd.isNotEmpty ||
        (optionWeaponsMap != null && optionWeaponsMap.isNotEmpty);

    final weaponsMod = hasWeaponMods
        ? UnitModifiers.swapWeapons(
            removeWeaponCodes: removeWeaponStrings,
            defaultWeaponsToAdd: defaultWeaponsToAdd,
            optionWeaponsMap: optionWeaponsMap,
          )
        : UnitModifiers.defaultWeaponsMod;

    return ModelUpgrade(
      name,
      id: id,
      type: type,
      description: description,
      tvMod: tvAdjustment == null
          ? UnitModifiers.defaultIntMod
          : UnitModifiers.adjustInt(tvAdjustment),
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
          : UnitModifiers.setHullStructure(h: hull, s: structure),
      actionsMod: actions == null
          ? UnitModifiers.defaultUnitActionsMod
          : (value, context) => value.copyWith(value: actions),
      guMod: gu == null
          ? UnitModifiers.defaultSkillMod
          : UnitModifiers.setSkill(gu),
      piMod: pi == null
          ? UnitModifiers.defaultSkillMod
          : UnitModifiers.setSkill(pi),
      ewMod: ew == null
          ? UnitModifiers.defaultSkillMod
          : UnitModifiers.setSkill(ew),
      weaponsMod: weaponsMod,
      traitsMod: traitsToAdd.isEmpty
          ? UnitModifiers.defaultTraitsMod
          : UnitModifiers.addTraits(traitsToAdd),
      upgradeOption: upgradeOption,
      requirementCheck: removeWeaponStrings.isEmpty
          ? (roster, squad, model) => true
          : (roster, squad, model) {
              final activeWeapons = model.getAttribute(
                ModelAttribute.weapons,
                excludeUpgradeId: id,
              );
              return removeWeaponStrings.every((removeCode) {
                final cleanCode = removeCode.trim().toUpperCase();
                return activeWeapons.any((spec) {
                  if (spec.code.toUpperCase() == cleanCode) return true;
                  return spec.weapons.any(
                    (w) => w.code.toUpperCase() == cleanCode,
                  );
                });
              });
            },
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
