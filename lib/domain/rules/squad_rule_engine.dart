import 'package:gearforce/domain/entities/attribute/command.dart';
import 'package:gearforce/domain/entities/attribute/unit_level.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';

/// Pure domain service responsible for squad constraint checks, command level resolution,
/// and rule enforcement during roster manipulations.
class SquadRuleEngine {
  static bool hasRequiredCommand(Iterable<Model> models, RuleSet ruleSet) {
    return ruleSet.commandLevelRule.hasRequiredCommand(models);
  }

  static Squad ensureRequiredCommand({
    required Squad squad,
    required List<Squad> allSquads,
    required RuleSet ruleSet,
  }) {
    if (hasRequiredCommand(squad.models, ruleSet)) {
      return squad;
    }

    final index = squad.models.indexWhere(
      (model) =>
          model.command == Command.none &&
          ruleSet.canAssignCommandLevel(
            model: model,
            newCommandLevel: Command.firstIC,
            squad: squad,
            allSquads: allSquads,
          ),
    );
    if (index == -1) {
      return squad;
    }

    final updatedModels = List<Model>.from(squad.models);
    updatedModels[index] = updatedModels[index].copyWith(
      command: Command.firstIC,
    );

    return squad.copyWith(models: updatedModels);
  }

  static List<Squad>? resolveCommandLevelChange({
    required Model model,
    required Command newCommandLevel,
    required Squad squad,
    required List<Squad> allSquads,
    required RuleSet ruleSet,
  }) {
    if (!ruleSet.canAssignCommandLevel(
      model: model,
      newCommandLevel: newCommandLevel,
      squad: squad,
      allSquads: allSquads,
    )) {
      return null;
    }

    final modelsToClear = ruleSet.getModelsToClearForCommandLevel(
      model: model,
      newCommandLevel: newCommandLevel,
      squad: squad,
      allSquads: allSquads,
    );

    var updatedSquads = List<Squad>.from(allSquads);
    final affectedSquadIds = <int>{squad.id};

    for (final entry in modelsToClear) {
      affectedSquadIds.add(entry.squad.id);
      final squadIndex = updatedSquads.indexWhere(
        (s) => s.id == entry.squad.id,
      );
      if (squadIndex != -1) {
        final targetSquad = updatedSquads[squadIndex];
        final updatedModels = targetSquad.models.map((m) {
          return m.id == entry.model.id ? m.copyWith(command: Command.none) : m;
        }).toList();
        updatedSquads[squadIndex] = targetSquad.copyWith(models: updatedModels);
      }
    }

    final targetSquadIndex = updatedSquads.indexWhere((s) => s.id == squad.id);
    if (targetSquadIndex != -1) {
      final targetSquad = updatedSquads[targetSquadIndex];
      final updatedModels = targetSquad.models.map((m) {
        return m.id == model.id ? m.copyWith(command: newCommandLevel) : m;
      }).toList();
      updatedSquads[targetSquadIndex] = targetSquad.copyWith(
        models: updatedModels,
      );
    }

    for (final squadId in affectedSquadIds) {
      final squadIndex = updatedSquads.indexWhere((s) => s.id == squadId);
      if (squadIndex != -1) {
        updatedSquads[squadIndex] = ensureRequiredCommand(
          squad: updatedSquads[squadIndex],
          allSquads: updatedSquads,
          ruleSet: ruleSet,
        );
      }
    }

    return updatedSquads;
  }

  static Squad? resolveLevelChange({
    required Model currentModel,
    required UnitLevel newLevel,
    required Squad squad,
    required List<Squad> allSquads,
    required RuleSet ruleSet,
  }) {
    final canAssignLevel = ruleSet.canAssignUnitLevel(
      model: currentModel,
      newLevel: newLevel,
      squad: squad,
      allSquads: allSquads,
    );
    if (!canAssignLevel) {
      return null;
    }

    final shouldClearCommand = ruleSet.shouldClearCommandOnLevelChange(
      model: currentModel,
      newLevel: newLevel,
      currentCommand: currentModel.command,
    );

    final newCommand = shouldClearCommand ? Command.none : currentModel.command;

    var modelsAfterLevelChange = [
      for (final m in squad.models)
        m.id == currentModel.id
            ? m.copyWith(level: newLevel, command: newCommand)
            : m,
    ];

    if (shouldClearCommand && currentModel.command != Command.none) {
      final squadAfterChange = squad.copyWith(models: modelsAfterLevelChange);
      final updatedSquads = [
        for (final s in allSquads) s.id == squad.id ? squadAfterChange : s,
      ];

      final needsFirstIC = !modelsAfterLevelChange.any(
        (m) => m.command == Command.firstIC,
      );

      if (needsFirstIC) {
        final unitToPromote = ruleSet.findEligibleUnitForCommandPromotion(
          commandLevel: Command.firstIC,
          availableModels: modelsAfterLevelChange
              .where((m) => m.id != currentModel.id)
              .toList(),
          squad: squadAfterChange,
          allSquads: updatedSquads,
        );

        if (unitToPromote != null) {
          modelsAfterLevelChange = [
            for (final m in modelsAfterLevelChange)
              m.id == unitToPromote.id
                  ? m.copyWith(command: Command.firstIC)
                  : m,
          ];
        }
      }
    }

    final squadAfterLevelChange = squad.copyWith(
      models: modelsAfterLevelChange,
    );
    final updatedSquadsForAssignment = [
      for (final s in allSquads) s.id == squad.id ? squadAfterLevelChange : s,
    ];

    if (newCommand == Command.none) {
      final needsFirstIC = !modelsAfterLevelChange.any(
        (m) => m.command == Command.firstIC,
      );

      if (needsFirstIC) {
        if (ruleSet.canAssignCommandLevel(
          model: currentModel.copyWith(level: newLevel),
          newCommandLevel: Command.firstIC,
          squad: squadAfterLevelChange,
          allSquads: updatedSquadsForAssignment,
        )) {
          modelsAfterLevelChange = [
            for (final m in modelsAfterLevelChange)
              m.id == currentModel.id
                  ? m.copyWith(command: Command.firstIC)
                  : m,
          ];
        }
      }
    }

    return squad.copyWith(models: modelsAfterLevelChange);
  }
}
