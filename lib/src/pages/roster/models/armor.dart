import 'package:meta/meta.dart';

@immutable
class Armor {
  final int value;

  const Armor({
    required this.value,
  }) : assert(value >= 0, 'Armor value must be 0 or positive');

  @override
  String toString() {
    if (value == 0) {
      return '-';
    }
    return '$value';
  }
}
