import 'package:gearforce/src/models/roster/unit/attribute/level.dart';
import 'package:gearforce/src/models/roster/unit/upgrade.dart';
import 'package:meta/meta.dart';

import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';

@immutable
class Squad {
  final String name;
  final Role primaryRole;
  final Role? secondaryRole;
  final List<Model> models;
  final Level level;
  final List<Upgrade> upgrades;

  const Squad({
    required this.name,
    this.primaryRole = Role.gp,
    this.secondaryRole,
    this.level = Level.regular,
    required this.models,
    this.upgrades = const [],
  });

  Squad copyWith({
    String? name,
    Role? primaryRole,
    Role? secondaryRole,
    bool allowSecondaryRoleToBeNull = false,
    Level? level,
    List<Model>? models,
    List<Upgrade>? upgrades,
  }) {
    return Squad(
      name: name ?? this.name,
      primaryRole: primaryRole ?? this.primaryRole,
      secondaryRole: allowSecondaryRoleToBeNull
          ? null
          : (secondaryRole ?? this.secondaryRole),
      level: level ?? this.level,
      models: models ?? this.models,
      upgrades: upgrades ?? this.upgrades,
    );
  }
}
