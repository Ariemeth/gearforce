import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'unit_actions.g.dart';

@immutable
@JsonSerializable()
class UnitActions {
  final int value;

  const UnitActions(this.value)
    : assert(value >= 0, 'UnitActions value must be 0 or positive');

  factory UnitActions.fromJson(dynamic json) {
    if (json is int) {
      return UnitActions(json);
    }
    throw ArgumentError(
      'UnitActions must be an int, but was ${json.runtimeType}',
    );
  }

  dynamic toJson() => value;

  UnitActions copyWith({int? value}) {
    return UnitActions(value ?? this.value);
  }

  @override
  String toString() {
    if (value == 0) {
      return '-';
    }
    return '$value';
  }
}
