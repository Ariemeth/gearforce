import 'package:json_annotation/json_annotation.dart';

enum WeaponMode {
  @JsonValue('direct')
  direct,
  @JsonValue('indirect')
  indirect,
}
