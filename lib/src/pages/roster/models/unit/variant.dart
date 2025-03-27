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
  final List<Weapon>? weapons;
  final List<Trait>? traits;

  Variant(
    this.name, {
    required this.id,
    required this.tv,
    Set<Role>? roles,
    this.movement,
    this.armor,
    this.hullStructure,
    this.actions,
    this.gu,
    this.pi,
    this.ew,
    List<Weapon>? weapons,
    List<Trait>? traits,
  })  : assert(id.trim().isNotEmpty, 'ID must not be empty or all whitespace'),
        assert(
            name.trim().isNotEmpty, 'Name must not be empty or all whitespace'),
        assert(tv >= 0, 'TV must be 0 or positive'),
        roles = roles != null ? Set.unmodifiable(roles) : null,
        weapons = weapons != null ? List.unmodifiable(weapons) : null,
        traits = traits != null ? List.unmodifiable(traits) : null;
}
