import 'package:gearforce/src/models/roster/unit/attribute/classification.dart';
import 'package:gearforce/src/models/roster/unit/model_base.dart';
import 'package:gearforce/src/models/roster/unit/upgrade.dart';
import 'package:gearforce/src/models/roster/unit/variant.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:meta/meta.dart';

@immutable
class Unit {
  final String name;
  final String id;
  final String subtype;
  final Classification classification;
  final String? manufacturer;
  final String? description;
  final ModelBase base;
  final List<Variant> variants;
  final List<Upgrade> upgrades;

  Unit(
    this.base, {
    required this.name,
    required this.id,
    required this.classification,
    required this.subtype,
    this.manufacturer,
    this.description,
    List<Variant> variants = const [],
    List<Upgrade> upgrades = const [],
  }) : assert(
         name.trim().isNotEmpty,
         'Name must not be empty or all whitespace',
       ),
       assert(id.trim().isNotEmpty, 'Id must not be empty or all whitespace'),
       variants = List.unmodifiable(variants),
       upgrades = List.unmodifiable(upgrades);

  Model buildModel(Variant variant) {
    if (!variants.any((v) => v.name == variant.name)) {
      throw ArgumentError('Variant ${variant.name} is not a variant of $name.');
    }

    return Model(
      name: '${variant.name} ${base.name}',
      tv: base.tv + variant.tv,
      roles: base.roles,
      movement: variant.movement ?? base.movement,
      armor: variant.armor ?? base.armor,
      hullStructure: variant.hullStructure ?? base.hullStructure,
      actions: variant.actions ?? base.actions,
      gu: variant.gu ?? base.gu,
      pi: variant.pi ?? base.pi,
      ew: variant.ew ?? base.ew,
      weapons: [...base.weapons, ...variant.weapons ?? []],
      traits: [...base.traits, ...variant.traits ?? []],
      height: base.height,
    );
  }

  @override
  String toString() =>
      'Unit(name: $name, type: $classification, subtype: $subtype)';
}
