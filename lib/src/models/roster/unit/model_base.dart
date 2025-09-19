import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/classification.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_spec.dart';
import 'package:meta/meta.dart';

@immutable
class ModelBase {
  final String name;
  final int tv;
  final Set<Role> roles;
  final Movement movement;
  final Armor armor;
  final HullStructure hullStructure;
  final UnitActions actions;
  final Skill gu;
  final Skill pi;
  final Skill ew;
  final List<WeaponSpec> weapons;
  final List<Trait> traits;
  final double height;

  final Classification classification;
  final String? subtype;
  final String? manufacturer;
  final String? description;

  const ModelBase(
    this.name, {
    required this.tv,
    required this.roles,
    required this.movement,
    required this.armor,
    required this.hullStructure,
    required this.actions,
    required this.gu,
    required this.pi,
    required this.ew,
    required this.weapons,
    required this.traits,
    required this.height,
    required this.classification,
    this.subtype,
    this.manufacturer,
    this.description,
  }) : assert(name.length > 0, 'Name must not be empty or all whitespace'),
       assert(tv >= 0, 'TV must be 0 or positive');
}
