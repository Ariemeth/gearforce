import 'package:json_annotation/json_annotation.dart';

enum Classification {
  @JsonValue('Cavalry')
  cavalry('Cavalry'),
  @JsonValue('Counter')
  counter('Counter'),
  @JsonValue('Fortifications')
  fortifications('Fortifications'),
  @JsonValue('Gear')
  gear('Gear'),
  @JsonValue('Infantry')
  infantry('Infantry'),
  @JsonValue('Strider')
  strider('Strider'),
  @JsonValue('Terrain')
  terrain('Terrain'),
  @JsonValue('Unknown')
  unknown('Unknown');

  final String name;

  const Classification(this.name);
}
