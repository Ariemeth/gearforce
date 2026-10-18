import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/weapon_parser.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';
import 'package:gearforce/data/static/trait_factory.dart';
import 'package:json_annotation/json_annotation.dart';

class WeaponSpecConverter implements JsonConverter<WeaponSpec, String> {
  const WeaponSpecConverter();

  @override
  WeaponSpec fromJson(String json) {
    return WeaponParser.parseWeaponString(json).first;
  }

  @override
  String toJson(WeaponSpec object) {
    return object.toString();
  }
}

class TraitConverter implements JsonConverter<Trait, String> {
  const TraitConverter();

  @override
  Trait fromJson(String json) {
    return TraitFactory.traitFromString(json);
  }

  @override
  String toJson(Trait object) {
    return object.toString();
  }
}

class TraitListConverter implements JsonConverter<List<Trait>, List<dynamic>> {
  const TraitListConverter();

  @override
  List<Trait> fromJson(List<dynamic> json) {
    return json.map((e) => TraitFactory.traitFromString(e as String)).toList();
  }

  @override
  List<String> toJson(List<Trait> object) {
    return object.map((e) => e.toString()).toList();
  }
}

class MountedWeaponSpecListConverter
    implements JsonConverter<List<WeaponSpec>, List<dynamic>> {
  const MountedWeaponSpecListConverter();

  @override
  List<WeaponSpec> fromJson(List<dynamic> json) {
    return json
        .expand((e) => WeaponParser.parseWeaponString(e as String))
        .toList();
  }

  @override
  List<String> toJson(List<WeaponSpec> object) {
    return object.map((e) => e.toString()).toList();
  }
}

class ReactWeaponSpecListConverter
    implements JsonConverter<List<WeaponSpec>, List<dynamic>> {
  const ReactWeaponSpecListConverter();

  @override
  List<WeaponSpec> fromJson(List<dynamic> json) {
    return json
        .expand(
          (e) => WeaponParser.parseWeaponString(e as String, hasReact: true),
        )
        .toList();
  }

  @override
  List<String> toJson(List<WeaponSpec> object) {
    return object.map((e) => e.toString()).toList();
  }
}
