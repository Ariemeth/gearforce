import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/entities/unit/unit_list_extensions.dart';

class UnitFilters {
  static bool matchAll(Unit _) => true;

  static UnitFilter matchByUnitRoles(Set<Role> roles) {
    return (Unit unit) {
      if (roles.isEmpty) {
        return true; // No roles to match, so all units are valid
      }
      final unitRoles = unit.base.roles;
      return unitRoles.any((role) => roles.contains(role));
    };
  }

  static UnitFilter matchByUnitAndVariantRoles(Set<Role> roles) {
    return (Unit unit) {
      if (roles.isEmpty) {
        return true; // No roles to match, so all units are valid
      }
      final baseRoles = unit.base.roles;
      final hasBaseRole = baseRoles.any((role) => roles.contains(role));
      if (hasBaseRole) {
        return true;
      }
      return unit.variants.any(
        (v) => v.roles?.any((r) => roles.contains(r)) ?? false,
      );
    };
  }
}
