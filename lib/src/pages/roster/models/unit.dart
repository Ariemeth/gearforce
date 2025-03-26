import 'package:meta/meta.dart';

import 'package:gearforce/src/pages/roster/models/armor.dart';
import 'package:gearforce/src/pages/roster/models/hull_structure.dart';
import 'package:gearforce/src/pages/roster/models/movement.dart';
import 'package:gearforce/src/pages/roster/models/model_actions.dart';
import 'package:gearforce/src/pages/roster/models/role.dart';
import 'package:gearforce/src/pages/roster/models/skill_attribute.dart';

@immutable
class Unit {
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
  final double height;

  const Unit({
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
    required this.height,
  });

  Unit copyWith({
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
    double? height,
  }) {
    return Unit(
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
      height: height ?? this.height,
    );
  }
}
