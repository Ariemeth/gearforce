import 'package:meta/meta.dart';

import 'package:gearforce/src/pages/roster/models/role.dart';
import 'package:gearforce/src/pages/roster/models/trait/trait.dart';
import 'package:gearforce/src/pages/roster/models/unit/armor.dart';
import 'package:gearforce/src/pages/roster/models/unit/hull_structure.dart';
import 'package:gearforce/src/pages/roster/models/unit/movement.dart';
import 'package:gearforce/src/pages/roster/models/unit/skill.dart';
import 'package:gearforce/src/pages/roster/models/unit/unit_actions.dart';
import 'package:gearforce/src/pages/roster/models/weapon/weapon.dart';

@immutable
class UnitBase {
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

  UnitBase(
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
  })  : assert(
            name.trim().isNotEmpty, 'Name must not be empty or all whitespace'),
        assert(tv >= 0, 'TV must be 0 or positive'),
        roles = Set.unmodifiable(roles),
        weapons = List.unmodifiable(weapons),
        traits = List.unmodifiable(traits);
}
