import 'package:meta/meta.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';

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
  final List<WeaponSpec>? reactWeapons;
  final List<WeaponSpec>? mountedWeapons;
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
    this.reactWeapons,
    this.mountedWeapons,
    this.traits,
  }) : assert(id.length > 0, 'ID must not be empty or all whitespace'),
       assert(name.length > 0, 'Name must not be empty or all whitespace'),
       assert(tv >= 0, 'TV must be 0 or positive');
}
