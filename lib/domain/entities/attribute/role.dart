import 'package:json_annotation/json_annotation.dart';

enum Role {
  @JsonValue('GP')
  gp('General Purpose', 'GP'),
  @JsonValue('SK')
  sk('Strike', 'SK'),
  @JsonValue('RC')
  rc('Recon', 'RC'),
  @JsonValue('FS')
  fs('Fire Support', 'FS'),
  @JsonValue('SO')
  so('Special Operations', 'SO'),
  @JsonValue('EG')
  eg('Engineering', 'EG'),
  @JsonValue('MB')
  mb('Mobile Base', 'MB'),
  @JsonValue('AS')
  as('Air Support', 'AS'),
  @JsonValue('FT')
  ft('Fortifications', 'FT');

  final String name;
  final String abbreviation;

  const Role(this.name, this.abbreviation);
}
