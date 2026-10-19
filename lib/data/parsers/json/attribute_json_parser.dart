import 'package:gearforce/data/static/trait_factory.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/movement_type.dart';
import 'package:gearforce/domain/entities/attribute/size_bands.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_range.dart';

class AttributeJsonParser {
  static Armor parseArmor(dynamic json) {
    if (json is int) {
      return Armor(json);
    }
    throw ArgumentError('Armor must be an int, but was ${json.runtimeType}');
  }

  static HullStructure parseHullStructure(Map<String, dynamic> json) {
    final hull = json['hull'] as int;
    final structure = json['structure'] as int;
    return HullStructure(hull: hull, structure: structure);
  }

  static Movement parseMovement(Map<String, dynamic> json) {
    final typesList = (json['types'] as List)
        .map(
          (e) => MovementType.values.firstWhere(
            (t) =>
                t.abbreviation.toLowerCase() == (e as String).toLowerCase() ||
                t.name.toLowerCase() == e.toLowerCase() ||
                t.toString().split('.').last.toLowerCase() == e.toLowerCase(),
            orElse: () => throw ArgumentError('Unknown MovementType: $e'),
          ),
        )
        .toList();
    final value = json['value'] as int;
    return Movement(typesList, value);
  }

  static Skill parseSkill(dynamic json) {
    if (json is int) {
      return Skill(json);
    }
    throw ArgumentError('Skill must be an int, but was ${json.runtimeType}');
  }

  static UnitActions parseUnitActions(dynamic json) {
    if (json is int) {
      return UnitActions(json);
    }
    throw ArgumentError(
      'UnitActions must be an int, but was ${json.runtimeType}',
    );
  }

  static WeaponRange parseWeaponRange(Map<String, dynamic> json) {
    final minOptimal = json['min'] as int?;
    final maxOptimal = json['opt'] as int?;
    final max = json['max'] as int?;
    return WeaponRange(
      minOptimal: minOptimal,
      maxOptimal: maxOptimal,
      max: max,
    );
  }

  static SizeBands<T> parseSizeBands<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return SizeBands<T>(
      l: fromJsonT(json['l']),
      m: fromJsonT(json['m']),
      h: fromJsonT(json['h']),
    );
  }

  static TraitSizeBands parseTraitSizeBands(Map<String, dynamic> json) {
    List<Trait> parseTraits(dynamic list) {
      if (list is! List) return const [];
      return list
          .map((e) => TraitFactory.traitFromString(e as String))
          .toList();
    }

    return TraitSizeBands(
      l: parseTraits(json['l']),
      m: parseTraits(json['m']),
      h: parseTraits(json['h']),
    );
  }

  static DamageSizeBands parseDamageSizeBands(Map<String, dynamic> json) {
    return DamageSizeBands(
      l: json['l'] as int,
      m: json['m'] as int,
      h: json['h'] as int,
    );
  }
}
