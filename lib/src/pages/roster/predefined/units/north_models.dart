import 'package:gearforce/src/pages/roster/models/unit/unit.dart';
import 'package:gearforce/src/pages/roster/predefined/units/north/hunter.dart';

class NorthUnits {
  static List<Unit> getUnits() {
    final hunter = createHunter();

    return [hunter];
  }
}
