import 'package:gearforce/data/parsers/json/attribute_json_parser.dart';
import 'package:gearforce/data/parsers/weapon_parser.dart';
import 'package:gearforce/data/static/trait_factory.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';

class VariantJsonParser {
  static Variant parseVariant(Map<String, dynamic> json) {
    final roles = (json['roles'] as List<dynamic>?)
        ?.map(
          (e) => Role.values.firstWhere(
            (r) =>
                r.abbreviation.toLowerCase() == (e as String).toLowerCase() ||
                r.name.toLowerCase() == e.toLowerCase(),
            orElse: () => throw ArgumentError('Unknown Role: $e'),
          ),
        )
        .toSet();

    final movement = json['movement'] != null
        ? AttributeJsonParser.parseMovement(
            json['movement'] as Map<String, dynamic>,
          )
        : null;

    final armor = json['armor'] != null
        ? AttributeJsonParser.parseArmor(json['armor'])
        : null;

    final hullStructure = json['hullStructure'] != null
        ? AttributeJsonParser.parseHullStructure(
            json['hullStructure'] as Map<String, dynamic>,
          )
        : null;

    final actions = json['actions'] != null
        ? AttributeJsonParser.parseUnitActions(json['actions'])
        : null;

    final gu = json['gu'] != null
        ? AttributeJsonParser.parseSkill(json['gu'])
        : null;

    final pi = json['pi'] != null
        ? AttributeJsonParser.parseSkill(json['pi'])
        : null;

    final ew = json['ew'] != null
        ? AttributeJsonParser.parseSkill(json['ew'])
        : null;

    final reactWeapons = json['reactWeapons'] != null
        ? (json['reactWeapons'] as List<dynamic>)
              .expand(
                (e) =>
                    WeaponParser.parseWeaponString(e as String, hasReact: true),
              )
              .toList()
        : null;

    final mountedWeapons = json['mountedWeapons'] != null
        ? (json['mountedWeapons'] as List<dynamic>)
              .expand((e) => WeaponParser.parseWeaponString(e as String))
              .toList()
        : null;

    final traits = json['traits'] != null
        ? (json['traits'] as List<dynamic>)
              .map((e) => TraitFactory.traitFromString(e as String))
              .toList()
        : null;

    return Variant(
      json['name'] as String,
      id: json['id'] as String,
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
    );
  }
}
