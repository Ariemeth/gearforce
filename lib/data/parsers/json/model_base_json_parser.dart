import 'package:gearforce/data/parsers/json/attribute_json_parser.dart';
import 'package:gearforce/data/parsers/weapon_parser.dart';
import 'package:gearforce/data/static/trait_factory.dart';
import 'package:gearforce/domain/entities/attribute/classification.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';
import 'package:gearforce/domain/entities/unit/model_base.dart';

class ModelBaseJsonParser {
  static ModelBase parseModelBase(Map<String, dynamic> json) {
    final roles = (json['roles'] as List<dynamic>)
        .map(
          (e) => Role.values.firstWhere(
            (r) =>
                r.abbreviation.toLowerCase() == (e as String).toLowerCase() ||
                r.name.toLowerCase() == e.toLowerCase(),
            orElse: () => throw ArgumentError('Unknown Role: $e'),
          ),
        )
        .toSet();

    final movement = AttributeJsonParser.parseMovement(
      json['movement'] as Map<String, dynamic>,
    );
    final armor = AttributeJsonParser.parseArmor(json['armor']);
    final hullStructure = AttributeJsonParser.parseHullStructure(
      json['hullStructure'] as Map<String, dynamic>,
    );
    final actions = AttributeJsonParser.parseUnitActions(json['actions']);
    final gu = AttributeJsonParser.parseSkill(json['gu']);
    final pi = AttributeJsonParser.parseSkill(json['pi']);
    final ew = AttributeJsonParser.parseSkill(json['ew']);

    final reactWeapons = json['reactWeapons'] != null
        ? (json['reactWeapons'] as List<dynamic>)
              .expand(
                (e) =>
                    WeaponParser.parseWeaponString(e as String, hasReact: true),
              )
              .toList()
        : const <WeaponSpec>[];

    final mountedWeapons = json['mountedWeapons'] != null
        ? (json['mountedWeapons'] as List<dynamic>)
              .expand((e) => WeaponParser.parseWeaponString(e as String))
              .toList()
        : const <WeaponSpec>[];

    final traits = json['traits'] != null
        ? (json['traits'] as List<dynamic>)
              .map((e) => TraitFactory.traitFromString(e as String))
              .toList()
        : const <Trait>[];

    final classificationStr = json['classification'] as String;
    final classification = Classification.values.firstWhere(
      (c) =>
          c.name.toLowerCase() == classificationStr.toLowerCase() ||
          c.toString().split('.').last.toLowerCase() ==
              classificationStr.toLowerCase(),
      orElse: () =>
          throw ArgumentError('Unknown Classification: $classificationStr'),
    );

    return ModelBase(
      json['name'] as String,
      unitId: json['unitId'] as String,
      tv: (json['tv'] as num).toInt(),
      roles: roles,
      movement: movement,
      armor: armor,
      hullStructure: hullStructure,
      actions: actions,
      gu: gu,
      pi: pi,
      ew: ew,
      reactWeapons: reactWeapons,
      mountedWeapons: mountedWeapons,
      traits: traits,
      height: (json['height'] as num).toDouble(),
      classification: classification,
      subtype: json['subtype'] as String?,
      manufacturer: json['manufacturer'] as String?,
      description: json['description'] as String?,
    );
  }
}
