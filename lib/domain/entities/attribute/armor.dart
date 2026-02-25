import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'armor.g.dart';

@immutable
@JsonSerializable()
class Armor {
  final int value;

  const Armor(this.value)
    : assert(value >= 0, 'Armor value must be 0 or positive');

  factory Armor.fromJson(dynamic json) {
    if (json is int) {
      return Armor(json);
    }
    throw ArgumentError('Armor must be an int, but was ${json.runtimeType}');
  }

  dynamic toJson() => value;

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
