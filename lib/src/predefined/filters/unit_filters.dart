import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/models/roster/unit/unit_list_extensions.dart';

class UnitFilters {
  static bool matchAll(Unit _) => true;

  static UnitFilter matchByRoles(Set<Role> roles) {
    return (Unit unit) {
      if (roles.isEmpty) {
        return true; // No roles to match, so all units are valid
      }
      final unitRoles = unit.base.roles;
      return unitRoles.any((role) => roles.contains(role));
    };
  }
}
