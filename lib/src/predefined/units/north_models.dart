import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/predefined/units/north/hunter.dart';

class NorthUnits {
  static List<Unit> getUnits() {
    final hunter = createHunter();

    return [hunter];
  }
}
