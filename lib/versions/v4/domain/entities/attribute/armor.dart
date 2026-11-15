import 'package:meta/meta.dart';

@immutable
class Armor {
  final int value;

  const Armor(this.value)
    : assert(value >= 0, 'Armor value must be 0 or positive');

  Armor copyWith({int? value}) {
    return Armor(value ?? this.value);
  }

  @override
  String toString() {
    if (value == 0) {
      return '-';
    }
    return '$value';
  }
}
