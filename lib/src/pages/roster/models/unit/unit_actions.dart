import 'package:meta/meta.dart';

@immutable
class UnitActions {
  final int value;

  const UnitActions(
    this.value,
  ) : assert(value >= 0, 'UnitActions value must be 0 or positive');

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
