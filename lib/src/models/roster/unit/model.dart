import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/trait/trait_list_extensions.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/level.dart';
import 'package:gearforce/src/models/roster/unit/attribute/model_attribute.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role_set_extensions.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/unit/command.dart';
import 'package:gearforce/src/models/roster/unit/unit_upgrade.dart';
import 'package:gearforce/src/models/roster/unit/unit_upgrade_context.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_spec.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_spec_list_extensions.dart';

class Model {
  // Fields
  final String _name;
  final int _tv;
  final Set<Role> _roles;
  final Movement _movement;
  final Armor _armor;
  final HullStructure _hullStructure;
  final UnitActions _actions;
  final Skill _gu;
  final Skill _pi;
  final Skill _ew;
  final List<WeaponSpec> _weapons;
  final List<Trait> _traits;
  final double _height;
  Level level;
  Command command;
  final List<UnitUpgrade> _upgrades = [];

  // Instance-level Set to track active getAttribute calls
  final Set<ModelAttribute> _activeAttributes = {};

  // Constructor
  Model({
    required String name,
    required int tv,
    required Set<Role> roles,
    required Movement movement,
    required Armor armor,
    required HullStructure hullStructure,
    required UnitActions actions,
    required Skill gu,
    required Skill pi,
    required Skill ew,
    List<WeaponSpec> weapons = const [],
    List<Trait> traits = const [],
    required double height,
    this.level = Level.regular,
    this.command = Command.none,
  }) : _name = name,
       _tv = tv,
       _roles = Set.unmodifiable(roles),
       _movement = movement,
       _armor = armor,
       _hullStructure = hullStructure,
       _actions = actions,
       _gu = gu,
       _pi = pi,
       _ew = ew,
       _weapons = List.unmodifiable(weapons),
       _traits = List.unmodifiable(traits),
       _height = height;

  // Getters
  String get name => getAttribute(ModelAttribute.name);
  int get tv => getAttribute(ModelAttribute.tv);
  Set<Role> get roles => getAttribute(ModelAttribute.roles);
  Movement get movement => getAttribute(ModelAttribute.movement);
  Armor get armor => getAttribute(ModelAttribute.armor);
  HullStructure get hullStructure => getAttribute(ModelAttribute.hullStructure);
  UnitActions get actions => getAttribute(ModelAttribute.actions);
  Skill get gu => getAttribute(ModelAttribute.gu);
  Skill get pi => getAttribute(ModelAttribute.pi);
  Skill get ew => getAttribute(ModelAttribute.ew);
  List<WeaponSpec> get weapons => getAttribute(ModelAttribute.weapons);
  List<Trait> get traits => getAttribute(ModelAttribute.traits);

  // Methods
  Model copyWith({
    String? name,
    int? threatValue,
    Set<Role>? roles,
    Movement? movement,
    Armor? armor,
    HullStructure? hullStructure,
    UnitActions? actions,
    Skill? gu,
    Skill? pi,
    Skill? ew,
    List<WeaponSpec>? weapons,
    List<Trait>? traits,
    List<UnitUpgrade>? upgrades,
    Level? level,
    Command? command,
    bool replaceUpgrades = false,
  }) {
    return Model(
        name: name ?? _name,
        tv: threatValue ?? _tv,
        roles: roles != null ? roles.copyWith() : _roles.copyWith(),
        movement: movement ?? _movement.copyWith(),
        armor: armor ?? _armor.copyWith(),
        hullStructure: hullStructure ?? _hullStructure.copyWith(),
        actions: actions ?? _actions.copyWith(),
        gu: gu ?? _gu.copyWith(),
        pi: pi ?? _pi.copyWith(),
        ew: ew ?? _ew.copyWith(),
        weapons: weapons?.copyWith() ?? _weapons.copyWith(),
        traits: traits?.copyWith() ?? _traits.copyWith(),
        height: _height,
        command: command ?? this.command,
        level: level ?? this.level,
      )
      .._upgrades.addAll(
        replaceUpgrades
            ? (upgrades ?? [])
            : [
                ..._upgrades.map((upgrade) => upgrade.copyWith()),
                ...(upgrades ?? []),
              ],
      );
  }

  Model addUpgrade(UnitUpgrade upgrade) {
    _upgrades.add(upgrade);
    return this;
  }

  Model removeUpgrade(UnitUpgrade upgrade) {
    _upgrades.remove(upgrade);
    return this;
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
          initialValue = _name as T;
          break;
        case ModelAttribute.tv:
          initialValue = _tv as T;
          break;
        case ModelAttribute.roles:
          initialValue = _roles as T;
          break;
        case ModelAttribute.movement:
          initialValue = _movement as T;
          break;
        case ModelAttribute.armor:
          initialValue = _armor as T;
          break;
        case ModelAttribute.hullStructure:
          initialValue = _hullStructure as T;
          break;
        case ModelAttribute.actions:
          initialValue = _actions as T;
          break;
        case ModelAttribute.gu:
          initialValue = _gu as T;
          break;
        case ModelAttribute.pi:
          initialValue = _pi as T;
          break;
        case ModelAttribute.ew:
          initialValue = _ew as T;
          break;
        case ModelAttribute.weapons:
          initialValue = _weapons as T;
          break;
        case ModelAttribute.traits:
          initialValue = _traits as T;
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

  // Private Helper Methods
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
