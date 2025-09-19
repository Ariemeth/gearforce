import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_spec.dart';
import 'package:meta/meta.dart';

@immutable
class Variant {
  final String id;
  final String name;
  final int tv;
  final Set<Role>? roles;
  final Movement? movement;
  final Armor? armor;
  final HullStructure? hullStructure;
  final UnitActions? actions;
  final Skill? gu;
  final Skill? pi;
  final Skill? ew;
  final List<WeaponSpec>? weapons;
  final List<Trait>? traits;

  const Variant(
    this.name, {
    required this.id,
    required this.tv,
    this.roles,
    this.movement,
    this.armor,
    this.hullStructure,
    this.actions,
    this.gu,
    this.pi,
    this.ew,
    this.weapons,
    this.traits,
  }) : assert(id.length > 0, 'ID must not be empty or all whitespace'),
       assert(name.length > 0, 'Name must not be empty or all whitespace'),
       assert(tv >= 0, 'TV must be 0 or positive');

  Model buildModel(Unit unit) {
    return Model(
      name: '$name ${unit.name}',
      tv: tv + unit.base.tv,
      roles: unit.base.roles.union(roles ?? {}),
      movement: movement ?? unit.base.movement,
      armor: armor ?? unit.base.armor,
      hullStructure: hullStructure ?? unit.base.hullStructure,
      actions: actions ?? unit.base.actions,
      gu: gu ?? unit.base.gu,
      pi: pi ?? unit.base.pi,
      ew: ew ?? unit.base.ew,
      weapons: [...unit.base.weapons, ...weapons ?? []],
      traits: [...unit.base.traits, ...traits ?? []],
      height: unit.base.height,
    );
  }
}
