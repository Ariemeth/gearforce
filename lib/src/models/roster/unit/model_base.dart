import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/weapon/weapon.dart';
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
  final List<Weapon> weapons;
  final List<Trait> traits;
  final double height;

  ModelBase(
    this.name, {
    required this.tv,
    required Set<Role> roles,
    required this.movement,
    required this.armor,
    required this.hullStructure,
    required this.actions,
    required this.gu,
    required this.pi,
    required this.ew,
    required List<Weapon> weapons,
    required List<Trait> traits,
    required this.height,
  }) : assert(
         name.trim().isNotEmpty,
         'Name must not be empty or all whitespace',
       ),
       assert(tv >= 0, 'TV must be 0 or positive'),
       roles = Set.unmodifiable(roles),
       weapons = List.unmodifiable(weapons),
       traits = List.unmodifiable(traits);
}
