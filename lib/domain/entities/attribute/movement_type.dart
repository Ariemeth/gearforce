import 'package:json_annotation/json_annotation.dart';

enum MovementType {
  @JsonValue('W')
  walker('Walker', 'W'),
  @JsonValue('G')
  ground('Ground', 'G'),
  @JsonValue('H')
  hover('Hover', 'H');

  final String name;
  final String abbreviation;

  const MovementType(this.name, this.abbreviation);
}
