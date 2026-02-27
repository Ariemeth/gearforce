import 'package:gearforce/data/repositories/json_converters.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/classification.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'model_base.g.dart';

@immutable
@JsonSerializable()
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
  @ReactWeaponSpecListConverter()
  final List<WeaponSpec> reactWeapons;
  @MountedWeaponSpecListConverter()
  final List<WeaponSpec> mountedWeapons;
  @TraitListConverter()
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

  factory ModelBase.fromJson(Map<String, dynamic> json) =>
      _$ModelBaseFromJson(json);

  Map<String, dynamic> toJson() => _$ModelBaseToJson(this);
}
