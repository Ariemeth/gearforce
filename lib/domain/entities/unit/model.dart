import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/unit_level.dart';
import 'package:gearforce/domain/entities/attribute/model_attribute.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/attribute/command.dart';
import 'package:gearforce/domain/entities/unit/model_base.dart';
import 'package:gearforce/domain/entities/unit/unit_upgrade.dart';
import 'package:gearforce/domain/entities/unit/unit_upgrade_context.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';

class Model {
  final int id;
  final ModelBase base;
  final Variant variant;
  final UnitLevel level;
  final Command command;
  final List<UnitUpgrade> _upgrades;
  final bool isDuelist;

  // Instance-level Set to track active getAttribute calls
  final Set<ModelAttribute> _activeAttributes = {};

  Model({
    required this.id,
    required this.base,
    required this.variant,
    this.level = UnitLevel.regular,
    this.command = Command.none,
    List<UnitUpgrade>? upgrades,
    this.isDuelist = false,
  }) : _upgrades = upgrades ?? [];

  String get name => getAttribute(ModelAttribute.name);
  int get tv =>
      getAttribute(ModelAttribute.tv) +
      level.cost +
      command.cost +
      (isDuelist ? 1 : 0);
  Set<Role> get roles => getAttribute(ModelAttribute.roles);
  Movement get movement => getAttribute(ModelAttribute.movement);
  Armor get armor => getAttribute(ModelAttribute.armor);
  HullStructure get hullStructure => getAttribute(ModelAttribute.hullStructure);
  UnitActions get actions => getAttribute(ModelAttribute.actions);
  Skill get gu => getAttribute(ModelAttribute.gu);
  Skill get pi => getAttribute(ModelAttribute.pi);
  Skill get ew => getAttribute(ModelAttribute.ew);
  List<WeaponSpec> get weapons => getAttribute(ModelAttribute.weapons);
  List<Trait> get traits => [
    ...getAttribute(ModelAttribute.traits),
    if (level == UnitLevel.green) Trait.green(),
  ];
  double get height => base.height;

  Model copyWith({
    int? id,
    Variant? variant,
    List<UnitUpgrade>? upgrades,
    UnitLevel? level,
    Command? command,
    bool? isDuelist,
  }) {
    return Model(
      base: base,
      id: id ?? this.id,
      variant: variant ?? this.variant,
      level: level ?? this.level,
      command: command ?? this.command,
      upgrades: upgrades ?? [..._upgrades.map((upgrade) => upgrade.copyWith())],
      isDuelist: isDuelist ?? this.isDuelist,
    );
  }

  Model addUpgrade(UnitUpgrade upgrade) {
    return copyWith(upgrades: [..._upgrades, upgrade]);
  }

  Model removeUpgrade(UnitUpgrade upgrade) {
    return copyWith(
      upgrades: [
        for (final u in _upgrades)
          if (u != upgrade) u,
      ],
    );
  }

  T getAttribute<T>(
    ModelAttribute<T> attribute, {
    String? excludeUpgradeId,
    String? upToUpgradeId,
  }) {
    if (_activeAttributes.contains(attribute)) {
      throw StateError(
        'Recursive call detected for getAttribute with $attribute',
      );
    }

    _activeAttributes.add(attribute);

    try {
      T initialValue;
      switch (attribute) {
        case ModelAttribute.name:
          initialValue =
              (variant.name == base.name
                      ? base.name
                      : '${variant.name} ${base.name}')
                  as T;
          break;
        case ModelAttribute.tv:
          initialValue = (base.tv + variant.tv) as T;
          break;
        case ModelAttribute.roles:
          initialValue = (base.roles.union(variant.roles ?? {})) as T;
          break;
        case ModelAttribute.movement:
          initialValue = (variant.movement ?? base.movement) as T;
          break;
        case ModelAttribute.armor:
          initialValue = (variant.armor ?? base.armor) as T;
          break;
        case ModelAttribute.hullStructure:
          initialValue = (variant.hullStructure ?? base.hullStructure) as T;
          break;
        case ModelAttribute.actions:
          initialValue = (variant.actions ?? base.actions) as T;
          break;
        case ModelAttribute.gu:
          initialValue = (variant.gu ?? base.gu) as T;
          break;
        case ModelAttribute.pi:
          initialValue = (variant.pi ?? base.pi) as T;
          break;
        case ModelAttribute.ew:
          initialValue = (variant.ew ?? base.ew) as T;
          break;
        case ModelAttribute.weapons:
          initialValue =
              ([
                    ...base.reactWeapons,
                    ...base.mountedWeapons,
                    ...variant.reactWeapons ?? <WeaponSpec>[],
                    ...variant.mountedWeapons ?? <WeaponSpec>[],
                  ])
                  as T;
          break;
        case ModelAttribute.traits:
          initialValue =
              ([...base.traits, ...variant.traits ?? <Trait>[]]) as T;
          break;
      }

      return _applyMods(
        initialValue,
        (upgrade, value, context) {
          switch (attribute) {
            case ModelAttribute.name:
              return upgrade.nameMod(value as String, context) as T;
            case ModelAttribute.tv:
              return upgrade.tvMod(value as int, context) as T;
            case ModelAttribute.roles:
              return upgrade.rolesMod(value as Set<Role>, context) as T;
            case ModelAttribute.movement:
              return upgrade.movementMod(value as Movement, context) as T;
            case ModelAttribute.armor:
              return upgrade.armorMod(value as Armor, context) as T;
            case ModelAttribute.hullStructure:
              return upgrade.hullStructureMod(value as HullStructure, context)
                  as T;
            case ModelAttribute.actions:
              return upgrade.actionsMod(value as UnitActions, context) as T;
            case ModelAttribute.gu:
              return upgrade.guMod(value as Skill, context) as T;
            case ModelAttribute.pi:
              return upgrade.piMod(value as Skill, context) as T;
            case ModelAttribute.ew:
              return upgrade.ewMod(value as Skill, context) as T;
            case ModelAttribute.weapons:
              return upgrade.weaponsMod(value as List<WeaponSpec>, context)
                  as T;
            case ModelAttribute.traits:
              return upgrade.traitsMod(value as List<Trait>, context) as T;
          }
        },
        excludeUpgradeId: excludeUpgradeId,
        upToUpgradeId: upToUpgradeId,
      );
    } finally {
      _activeAttributes.remove(attribute);
    }
  }

  T _applyMods<T>(
    T initialValue,
    T Function(UnitUpgrade mod, T value, UnitUpgradeContext context)
    modFunction, {
    String? excludeUpgradeId,
    String? upToUpgradeId,
  }) {
    assert(
      excludeUpgradeId == null || upToUpgradeId == null,
      'Only one of excludeUpgradeId or upToUpgradeId can be specified.',
    );

    var value = initialValue;
    for (final upgrade in _upgrades) {
      if (excludeUpgradeId != null && upgrade.id == excludeUpgradeId) {
        continue;
      }
      final context = UnitUpgradeContext(this, upgrade);
      value = modFunction(upgrade, value, context);
      if (upToUpgradeId != null && upgrade.id == upToUpgradeId) {
        break;
      }
    }
    return value;
  }
}
