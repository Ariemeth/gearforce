import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/predefined/units/blackTalons/dark_warrior.dart';

List<Unit> getBlackTalonUnits() {
  final darkWarrior = createDarkWarrior();
  return [darkWarrior];
}
