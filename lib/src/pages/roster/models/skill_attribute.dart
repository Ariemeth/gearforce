import 'package:meta/meta.dart';

@immutable
class SkillAttribute {
  final int value;

  const SkillAttribute(
    this.value,
  ) : assert(value >= 0, 'Value must be 0 or positive');

  @override
  String toString() {
    if (value == 0) {
      return '-';
    }
    return '$value+';
  }
}
