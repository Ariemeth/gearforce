import 'package:meta/meta.dart';

import 'package:gearforce/src/models/roster/unit/attribute/classification.dart';
import 'package:gearforce/src/models/roster/unit/upgrade.dart';
import 'package:gearforce/src/models/roster/unit/unit_base.dart';
import 'package:gearforce/src/models/roster/unit/variant.dart';

@immutable
class Unit {
  final String name;
  final String id;
  final String subtype;
  final Classification classification;
  final String? manufacturer;
  final String? description;
  final UnitBase base;
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
  })  : assert(
            name.trim().isNotEmpty, 'Name must not be empty or all whitespace'),
        assert(id.trim().isNotEmpty, 'Id must not be empty or all whitespace'),
        variants = List.unmodifiable(variants),
        upgrades = List.unmodifiable(upgrades);

  @override
  String toString() =>
      'Unit(name: $name, type: $classification, subtype: $subtype)';
}
