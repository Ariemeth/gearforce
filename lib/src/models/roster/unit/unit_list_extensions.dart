import 'package:gearforce/src/models/roster/unit/unit.dart';

typedef UnitFilter = bool Function(Unit unit);

extension UnitListExtension on List<Unit> {
  List<Unit> filterBy(UnitFilter filter) {
    return where((unit) => filter(unit)).toList();
  }
}
