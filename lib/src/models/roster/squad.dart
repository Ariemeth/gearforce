import 'package:meta/meta.dart';

import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';

@immutable
class Squad {
  final String name;
  final Role primaryRole;
  final Role? secondaryRole;
  final List<Model> models;

  const Squad({
    required this.name,
    this.primaryRole = Role.gp,
    this.secondaryRole,
    required this.models,
  });

  Squad copyWith({
    String? name,
    Role? primaryRole,
    Role? secondaryRole,
    bool allowSecondaryRoleToBeNull = false,
    List<Model>? models,
  }) {
    return Squad(
      name: name ?? this.name,
      primaryRole: primaryRole ?? this.primaryRole,
      secondaryRole: allowSecondaryRoleToBeNull
          ? null
          : (secondaryRole ?? this.secondaryRole),
      models: models ?? this.models,
    );
  }
}
