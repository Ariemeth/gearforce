import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:gearforce/domain/entities/attribute/movement_type.dart';

part 'movement.g.dart';

@immutable
@JsonSerializable()
class Movement {
  final List<MovementType> types;
  final int value;

  const Movement(this.types, this.value)
    : assert(value >= 0, 'Movement value must be 0 or positive');

  factory Movement.fromJson(Map<String, dynamic> json) =>
      _$MovementFromJson(json);

  Map<String, dynamic> toJson() => _$MovementToJson(this);

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
