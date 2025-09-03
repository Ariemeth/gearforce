import 'package:gearforce/src/models/roster/unit/attribute/level.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:gearforce/src/models/roster/unit/upgrade.dart';
import 'package:meta/meta.dart';

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

  /// Validates and filters units in a squad based on primary and secondary roles
  static Squad filterValidSquadUnits(Squad squad) {
    // final validModels = squad.models.where((model) {
    //   final unitRoles = model.roles;
    //   return unitRoles.contains(squad.primaryRole) ||
    //       (squad.secondaryRole != null &&
    //           unitRoles.contains(squad.secondaryRole));
    // }).toList();
    final validModels = squad.models
        .where(
          (model) => model.roles.any(
            (role) => role == squad.primaryRole || role == squad.secondaryRole,
          ),
        )
        .toList();

    // Only update if models were filtered out
    if (validModels.length != squad.models.length) {
      return squad.copyWith(models: validModels);
    }

    return squad;
  }
}
