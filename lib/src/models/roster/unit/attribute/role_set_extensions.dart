import 'package:gearforce/src/models/roster/unit/attribute/role.dart';

extension RoleSetExtension on Set<Role> {
  /// Returns a deep copy of the set of roles.
  Set<Role> copyWith() {
    return map((role) => Role.values.firstWhere((r) => r == role)).toSet();
  }
}
