import 'package:meta/meta.dart';

@immutable
class Unit {
  final String name;
  final String chassisType;
  final int threatValue;

  const Unit({
    required this.name,
    required this.chassisType,
    required this.threatValue,
  });
}
