import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/unit_level.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/model_list_extensions.dart';
import 'package:gearforce/domain/entities/unit/unit_upgrade.dart';
import 'package:meta/meta.dart';

@immutable
class Squad {
  final int id;
  final String name;
  final Role primaryRole;
  final Role? secondaryRole;
  final List<Model> models;
  final List<UnitUpgrade> upgrades;

  const Squad({
    required this.id,
    required this.name,
    this.primaryRole = Role.gp,
    this.secondaryRole,
    required this.models,
    this.upgrades = const [],
  });

  int get tv => models.tv;
  int get numGreenSquads =>
      models.where((m) => m.level == UnitLevel.green).length;
  int get numVetSquads =>
      models.where((m) => m.level == UnitLevel.veteran).length;
  int get numEliteSquads =>
      models.where((m) => m.level == UnitLevel.elite).length;
  int get numDuelists => models.where((m) => m.isDuelist).length;

  Squad copyWith({
    String? name,
    int? id,
    Role? primaryRole,
    Role? secondaryRole,
    bool allowSecondaryRoleToBeNull = false,
    List<Model>? models,
    List<UnitUpgrade>? upgrades,
  }) {
    return Squad(
      name: name ?? this.name,
      id: id ?? this.id,
      primaryRole: primaryRole ?? this.primaryRole,
      secondaryRole: allowSecondaryRoleToBeNull
          ? null
          : (secondaryRole ?? this.secondaryRole),
      models: models ?? this.models,
      upgrades: upgrades ?? this.upgrades,
    );
  }

  /// Validates and filters units in a squad based on primary and secondary roles
  static Squad filterValidSquadUnits(Squad squad) {
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
