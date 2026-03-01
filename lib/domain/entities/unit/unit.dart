import 'package:gearforce/domain/entities/unit/model_base.dart';
import 'package:gearforce/domain/entities/unit/model_upgrade.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'unit.g.dart';

@immutable
@JsonSerializable()
class Unit {
  final String id;
  @JsonKey(name: 'base')
  final ModelBase base;
  final List<Variant> variants;
  @JsonKey(name: 'upgrades')
  final List<ModelUpgrade> availableProfileUpgrades;

  const Unit(
    this.base, {
    required this.id,
    this.variants = const [],
    this.availableProfileUpgrades = const [],
  }) : assert(id.length != 0, 'Id must not be empty');

  factory Unit.fromJson(Map<String, dynamic> json) {
    // Flatten ModelBase fields if they are at the top level in JSON
    final Map<String, dynamic> baseJson;
    if (json.containsKey('base')) {
      baseJson = json['base'] as Map<String, dynamic>;
    } else {
      baseJson = Map<String, dynamic>.from(json);
      // Ensure hullStructure is present if hull/structure are top-level
      if (json.containsKey('hull') && json.containsKey('structure')) {
        baseJson['hullStructure'] = {
          'hull': json['hull'],
          'structure': json['structure'],
        };
      }
    }

    // Add unitId to baseJson (from Unit's id field)
    baseJson['unitId'] = json['id'];

    return Unit(
      ModelBase.fromJson(baseJson),
      id: json['id'] as String,
      variants: json['variants'] != null
          ? (json['variants'] as List)
                .map((e) => Variant.fromJson(e as Map<String, dynamic>))
                .toList()
          : const [],
      availableProfileUpgrades: json['upgrades'] != null
          ? (json['upgrades'] as List)
                .map((e) => ModelUpgrade.fromJson(e as Map<String, dynamic>))
                .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() => _$UnitToJson(this);

  String get name => base.name;

  @override
  String toString() =>
      'Unit(name: $name, type: ${base.classification}, subtype: ${base.subtype})';
}
