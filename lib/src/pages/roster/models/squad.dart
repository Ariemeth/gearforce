import 'package:gearforce/src/pages/roster/models/role.dart';
import 'package:meta/meta.dart';
import 'package:gearforce/src/pages/roster/models/unit.dart';

@immutable
class Squad {
  final String id;
  final Role primaryRole;
  final Role? secondaryRole;
  final List<Unit> units;

  const Squad({
    required this.id,
    this.primaryRole = Role.gp,
    this.secondaryRole,
    required this.units,
  });

  Squad copyWith({
    String? id,
    Role? primaryRole,
    Role? secondaryRole,
    bool allowSecondaryRoleToBeNull = false,
    List<Unit>? units,
  }) {
    return Squad(
      id: id ?? this.id,
      primaryRole: primaryRole ?? this.primaryRole,
      secondaryRole: allowSecondaryRoleToBeNull
          ? null
          : (secondaryRole ?? this.secondaryRole),
      units: units ?? this.units,
    );
  }
}
