import 'package:meta/meta.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/classification.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';

@immutable
class ModelBase {
  final String unitId;
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
  final List<WeaponSpec> reactWeapons;
  final List<WeaponSpec> mountedWeapons;
  final List<Trait> traits;
  final double height;

  final Classification classification;
  final String? subtype;
  final String? manufacturer;
  final String? description;

  const ModelBase(
    this.name, {
    required this.unitId,
    required this.tv,
    required this.roles,
    required this.movement,
    required this.armor,
    required this.hullStructure,
    required this.actions,
    required this.gu,
    required this.pi,
    required this.ew,
    this.reactWeapons = const [],
    this.mountedWeapons = const [],
    this.traits = const [],
    required this.height,
    required this.classification,
    this.subtype,
    this.manufacturer,
    this.description,
  }) : assert(name.length > 0, 'Name must not be empty or all whitespace'),
       assert(tv >= 0, 'TV must be 0 or positive');
}
