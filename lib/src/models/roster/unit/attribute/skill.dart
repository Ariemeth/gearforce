import 'package:meta/meta.dart';

@immutable
class Skill {
  final int value;

  const Skill(this.value) : assert(value >= 0, 'Value must be 0 or positive');

  Skill copyWith({int? value}) {
    return Skill(value ?? this.value);
  }

  @override
  String toString() {
    if (value == 0) {
      return '-';
    }
    return '$value+';
  }
}
