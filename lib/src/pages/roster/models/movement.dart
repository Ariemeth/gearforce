import 'package:meta/meta.dart';

import 'package:gearforce/src/pages/roster/models/movement_type.dart';

@immutable
class Movement {
  final List<MovementType> types;
  final int value;

  const Movement({
    required this.types,
    required this.value,
  }) : assert(value >= 0, 'Movement value must be 0 or positive');

  @override
  String toString() {
    if (types.isEmpty) {
      return '-';
    }
    final typeAbbreviations = types.map((type) => type.abbreviation).join('/');
    return '$typeAbbreviations: $value';
  }
}
