import 'package:meta/meta.dart';
import 'package:gearforce/domain/entities/unit/model_base.dart';
import 'package:gearforce/domain/entities/unit/model_upgrade.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';

@immutable
class Unit {
  final String id;
  final ModelBase base;
  final List<Variant> variants;
  final List<ModelUpgrade> availableProfileUpgrades;

  const Unit(
    this.base, {
    required this.id,
    this.variants = const [],
    this.availableProfileUpgrades = const [],
  }) : assert(id.length != 0, 'Id must not be empty');

  String get name => base.name;

  @override
  String toString() =>
      'Unit(name: $name, type: ${base.classification}, subtype: ${base.subtype})';
}
