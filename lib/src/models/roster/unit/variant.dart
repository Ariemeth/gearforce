import 'package:meta/meta.dart';

import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/weapon/weapon.dart';

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
