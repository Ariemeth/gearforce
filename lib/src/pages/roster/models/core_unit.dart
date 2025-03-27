import 'package:meta/meta.dart';

import 'package:gearforce/src/pages/roster/models/armor.dart';
import 'package:gearforce/src/pages/roster/models/hull_structure.dart';
import 'package:gearforce/src/pages/roster/models/movement.dart';
import 'package:gearforce/src/pages/roster/models/model_actions.dart';
import 'package:gearforce/src/pages/roster/models/role.dart';
import 'package:gearforce/src/pages/roster/models/skill_attribute.dart';
import 'package:gearforce/src/pages/roster/models/trait.dart';

@immutable
class CoreUnit {
  final String name;
  final String chassisType;
  final int threatValue;
  final List<Role> roles;
  final Movement movement;
  final Armor armor;
  final HullStructure hullStructure;
  final ModelActions actions;
  final SkillAttribute gu;
  final SkillAttribute pi;
  final SkillAttribute ew;
  final Set<Trait> traits;
  final double height;

  CoreUnit({
    required this.name,
    required this.chassisType,
    required this.threatValue,
    required this.roles,
    required this.movement,
    required this.armor,
    required this.hullStructure,
    required this.actions,
    required this.gu,
    required this.pi,
    required this.ew,
    Set<Trait> traits = const {},
    required this.height,
  }) : traits = Set.unmodifiable(traits);
  CoreUnit copyWith({
    String? name,
    String? chassisType,
    int? threatValue,
    List<Role>? roles,
    Movement? movement,
    Armor? armor,
    HullStructure? hullStructure,
    ModelActions? actions,
    SkillAttribute? gu,
    SkillAttribute? pi,
    SkillAttribute? ew,
    Set<Trait>? traits,
    double? height,
  }) {
    return CoreUnit(
      name: name ?? this.name,
      chassisType: chassisType ?? this.chassisType,
      threatValue: threatValue ?? this.threatValue,
      roles: roles != null && roles.isNotEmpty ? roles : this.roles,
      movement: movement ?? this.movement,
      armor: armor ?? this.armor,
      hullStructure: hullStructure ?? this.hullStructure,
      actions: actions ?? this.actions,
      gu: gu ?? this.gu,
      pi: pi ?? this.pi,
      ew: ew ?? this.ew,
      traits: traits ?? this.traits,
      height: height ?? this.height,
    );
  }
}
