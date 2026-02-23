import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'skill.g.dart';

@immutable
@JsonSerializable()
class Skill {
  final int value;

  const Skill(this.value) : assert(value >= 0, 'Value must be 0 or positive');

  factory Skill.fromJson(dynamic json) {
    if (json is int) {
      return Skill(json);
    }
    throw ArgumentError('Skill must be an int, but was ${json.runtimeType}');
  }

  dynamic toJson() => value;

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
