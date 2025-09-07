import 'package:meta/meta.dart';

import 'package:gearforce/src/models/roster/unit/attribute/movement_type.dart';

@immutable
class Movement {
  final List<MovementType> types;
  final int value;

  const Movement(this.types, this.value)
    : assert(value >= 0, 'Movement value must be 0 or positive');

  Movement copyWith({List<MovementType>? types, int? value}) {
    return Movement(types ?? this.types, value ?? this.value);
  }

  @override
  String toString() {
    if (types.isEmpty) {
      return '-';
    }
    final typeAbbreviations = types.map((type) => type.abbreviation).join('/');
    return '$typeAbbreviations: $value';
  }
}
