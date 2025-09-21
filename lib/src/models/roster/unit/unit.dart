import 'package:gearforce/src/models/roster/unit/model_base.dart';
import 'package:gearforce/src/models/roster/unit/unit_upgrade.dart';
import 'package:gearforce/src/models/roster/unit/variant.dart';
import 'package:meta/meta.dart';

@immutable
class Unit {
  final String id;
  final ModelBase base;
  final List<Variant> variants;
  final List<UnitUpgrade> upgrades;

  const Unit(
    this.base, {
    required this.id,
    this.variants = const [],
    this.upgrades = const [],
  }) : assert(id.length != 0, 'Id must not be empty or all whitespace');

  String get name => base.name;

  @override
  String toString() =>
      'Unit(name: $name, type: ${base.classification}, subtype: ${base.subtype})';
}
