import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/predefined/units/north/hunter.dart';

List<Unit> getNorthUnits() {
  final hunter = createHunter();
  return [hunter];
}
