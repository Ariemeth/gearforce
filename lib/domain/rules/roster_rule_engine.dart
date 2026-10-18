import 'package:gearforce/domain/entities/attribute/command.dart';
import 'package:gearforce/domain/entities/attribute/unit_level.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/rules/squad_rule_engine.dart';

/// Validation report containing status, errors, and warnings for a complete Roster.
class RosterValidationResult {
  final bool isValid;
  final List<String> errors;
  final List<String> warnings;

  const RosterValidationResult({
    required this.isValid,
    this.errors = const [],
    this.warnings = const [],
  });
}

/// Pure domain service responsible for force-wide (multi-squad) calculations,
/// squad duplication with cross-force command resolution, and roster validation.
class RosterRuleEngine {
  /// Calculates total Threat Value (TV) across all squads in the roster.
  static int calculateTotalTv(List<Squad> squads) {
    return squads.fold<int>(0, (sum, squad) => sum + squad.tv);
  }

  /// Calculates total model count across all squads.
  static int calculateModelCount(List<Squad> squads) {
    return squads.fold<int>(0, (sum, squad) => sum + squad.models.length);
  }

  /// Calculates total force activation count (number of active squads).
  static int calculateActivationCount(List<Squad> squads) {
    return squads.length;
  }

  /// Calculates total Command Points (CP) generated across all squads.
  static int calculateTotalCp(List<Squad> squads) {
    int totalCp = 0;
    for (final squad in squads) {
      for (final model in squad.models) {
        switch (model.command) {
          case Command.co:
            totalCp += 3;
            break;
          case Command.xo:
            totalCp += 2;
            break;
          case Command.firstIC:
            totalCp += 1;
            break;
          case Command.secondIC:
            totalCp += 1;
            break;
          case Command.none:
            break;
        }
      }
    }
    return totalCp;
  }

  /// Duplicates an existing squad while resolving cross-squad command constraints and IDs.
  static List<Squad> duplicateSquad({
    required Squad squadToDuplicate,
    required String newSquadName,
    required List<Squad> currentSquads,
    required RuleSet ruleSet,
    required int Function() nextSquadIdGenerator,
    required int Function() nextModelIdGenerator,
  }) {
    final newSquadId = nextSquadIdGenerator();

    final duplicatedModels = [
      for (final model in squadToDuplicate.models)
        model.copyWith(id: nextModelIdGenerator(), command: Command.none),
    ];

    var duplicatedSquad = squadToDuplicate.copyWith(
      id: newSquadId,
      name: newSquadName,
      models: duplicatedModels,
    );

    final updatedSquads = List<Squad>.from(currentSquads)..add(duplicatedSquad);

    const commandCopyOrder = [
      Command.co,
      Command.xo,
      Command.firstIC,
      Command.secondIC,
    ];

    for (final commandLevel in commandCopyOrder) {
      for (var index = 0; index < squadToDuplicate.models.length; index++) {
        final sourceModel = squadToDuplicate.models[index];
        if (sourceModel.command != commandLevel) {
          continue;
        }

        final candidate = duplicatedSquad.models[index];
        final canAssign = ruleSet.canAssignCommandLevel(
          model: candidate,
          newCommandLevel: commandLevel,
          squad: duplicatedSquad,
          allSquads: updatedSquads,
        );

        final conflictingModels = ruleSet.getModelsToClearForCommandLevel(
          model: candidate,
          newCommandLevel: commandLevel,
          squad: duplicatedSquad,
          allSquads: updatedSquads,
        );

        if (!canAssign || conflictingModels.isNotEmpty) {
          continue;
        }

        final updatedModels = List<Model>.from(duplicatedSquad.models);
        updatedModels[index] = candidate.copyWith(command: commandLevel);
        duplicatedSquad = duplicatedSquad.copyWith(models: updatedModels);
        updatedSquads[updatedSquads.length - 1] = duplicatedSquad;
      }
    }

    duplicatedSquad = SquadRuleEngine.ensureRequiredCommand(
      squad: duplicatedSquad,
      allSquads: updatedSquads,
      ruleSet: ruleSet,
    );
    updatedSquads[updatedSquads.length - 1] = duplicatedSquad;

    return updatedSquads;
  }

  /// Validates the complete force roster against active ruleset constraints.
  static RosterValidationResult validateRoster({
    required List<Squad> squads,
    required RuleSet ruleSet,
  }) {
    final errors = <String>[];
    final warnings = <String>[];

    if (squads.isEmpty) {
      errors.add('Force requires at least one squad.');
      return RosterValidationResult(isValid: false, errors: errors);
    }

    for (var i = 0; i < squads.length; i++) {
      final squad = squads[i];
      if (!ruleSet.isSquadComplete(squad)) {
        errors.add('Squad ${squad.name} (${i + 1}) is incomplete.');
      }
    }

    return RosterValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }

  /// Sanitizes squads to ensure they comply with the asset table limits
  /// and command requirements of a new RuleSet.
  static List<Squad> sanitizeRosterForRuleSet({
    required List<Squad> squads,
    required RuleSet ruleSet,
  }) {
    if (squads.isEmpty) {
      return squads;
    }

    var updatedSquads = List<Squad>.from(squads);

    // 1. Sanitize Duelists based on assetTable.duelistOrAces
    final duelistLimit = ruleSet.assetTable.duelistOrAces;
    if (duelistLimit != null) {
      int duelistCount = 0;
      for (var sIdx = 0; sIdx < updatedSquads.length; sIdx++) {
        final squad = updatedSquads[sIdx];
        var squadModelsChanged = false;
        final updatedModels = <Model>[];

        for (final model in squad.models) {
          if (model.isDuelist) {
            if (duelistCount < duelistLimit) {
              duelistCount++;
              updatedModels.add(model);
            } else {
              // Exceeds limit, remove duelist status
              updatedModels.add(model.copyWith(isDuelist: false));
              squadModelsChanged = true;
            }
          } else {
            updatedModels.add(model);
          }
        }

        if (squadModelsChanged) {
          updatedSquads[sIdx] = squad.copyWith(models: updatedModels);
        }
      }
    }

    // 2. Sanitize Unit Levels (green, veteran, elite)
    final levelLimits = {
      UnitLevel.green: ruleSet.assetTable.greenSquads,
      UnitLevel.veteran: ruleSet.assetTable.veteranSquads,
      UnitLevel.elite: ruleSet.assetTable.eliteSquads,
    };

    for (final entry in levelLimits.entries) {
      final level = entry.key;
      final limit = entry.value;
      if (limit == null) {
        continue;
      }

      int squadsWithLevelCount = 0;
      for (var sIdx = 0; sIdx < updatedSquads.length; sIdx++) {
        final squad = updatedSquads[sIdx];
        final hasLevel = squad.models.any((m) => m.level == level);
        if (hasLevel) {
          if (squadsWithLevelCount < limit) {
            squadsWithLevelCount++;
          } else {
            // Exceeds limit for this level, revert models with this level to regular
            final updatedModels = squad.models.map((m) {
              return m.level == level
                  ? m.copyWith(level: UnitLevel.regular)
                  : m;
            }).toList();
            updatedSquads[sIdx] = squad.copyWith(models: updatedModels);
          }
        }
      }
    }

    // 3. Ensure required command for each squad under new RuleSet
    for (var sIdx = 0; sIdx < updatedSquads.length; sIdx++) {
      updatedSquads[sIdx] = SquadRuleEngine.ensureRequiredCommand(
        squad: updatedSquads[sIdx],
        allSquads: updatedSquads,
        ruleSet: ruleSet,
      );
    }

    return updatedSquads;
  }
}
