import 'package:meta/meta.dart';

import 'package:gearforce/src/pages/roster/models/role.dart';
import 'package:gearforce/src/pages/roster/models/unit_core.dart';

@immutable
class Squad {
  final String name;
  final Role primaryRole;
  final Role? secondaryRole;
  final List<UnitCore> units;

  const Squad({
    required this.name,
    this.primaryRole = Role.gp,
    this.secondaryRole,
    required this.units,
  });

  Squad copyWith({
    String? name,
    Role? primaryRole,
    Role? secondaryRole,
    bool allowSecondaryRoleToBeNull = false,
    List<UnitCore>? units,
  }) {
    return Squad(
      name: name ?? this.name,
      primaryRole: primaryRole ?? this.primaryRole,
      secondaryRole: allowSecondaryRoleToBeNull
          ? null
          : (secondaryRole ?? this.secondaryRole),
      units: units ?? this.units,
    );
  }
}
