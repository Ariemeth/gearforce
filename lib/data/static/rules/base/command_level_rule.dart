import 'package:gearforce/domain/entities/attribute/command.dart';
import 'package:gearforce/domain/entities/faction/rule.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:meta/meta.dart';

@immutable
class CommandLevelRule extends Rule {
  static const CommandLevelRule standard = CommandLevelRule();

  const CommandLevelRule({
    super.name = 'Command Level Rule',
    super.id = 'command-level-rule',
    super.description =
        'Defines command level eligibility constraints and squad requirements.',
    super.isEnabled = true,
    super.canBeToggled = false,
    super.requirementCheck,
  });

  /// Every squad must include at least one of 1iC, CO, or XO.
  bool hasRequiredCommand(Iterable<Model> models) {
    return models.any(
      (model) =>
          model.command == Command.firstIC ||
          model.command == Command.co ||
          model.command == Command.xo,
    );
  }

  /// Validates if the given command level can be assigned to a model in a squad.
  ///
  /// Returns true if the assignment is valid, false otherwise.
  ///
  /// Rules:
  /// - Only one 1iC per squad
  /// - Only one 2iC per squad
  /// - Only one CO per roster (checked via allSquads)
  /// - Only one XO per roster (checked via allSquads)
  /// - A squad can only have one 1iC
  /// - A squad can include XO instead of a 2iC when a CO is present
  /// - 1iC, CO, and XO can only be assigned to units with the squad's primary role
  bool canAssignCommandLevel({
    required Model model,
    required Command newCommandLevel,
    required Squad squad,
    required List<Squad> allSquads,
  }) {
    // None is always allowed
    if (newCommandLevel == Command.none) {
      return true;
    }

    // Check role constraint for command levels that require the primary role
    if (newCommandLevel == Command.firstIC ||
        newCommandLevel == Command.co ||
        newCommandLevel == Command.xo) {
      if (!model.roles.contains(squad.primaryRole)) {
        return false;
      }
    }

    // Get all models in the squad except the one being updated
    final otherModelsInSquad = squad.models
        .where((m) => m.id != model.id)
        .toList();

    // Get all models in all squads except the one being updated
    final allOtherModels = allSquads
        .expand((s) => s.models)
        .where((m) => m.id != model.id)
        .toList();

    // Check squad-level constraints
    if (newCommandLevel == Command.firstIC) {
      // Only one 1iC per squad
      if (otherModelsInSquad.any((m) => m.command == Command.firstIC)) {
        return false;
      }
      // 1iC cannot coexist with CO or XO
      if (otherModelsInSquad.any(
        (m) => m.command == Command.co || m.command == Command.xo,
      )) {
        return false;
      }
    }

    if (newCommandLevel == Command.secondIC) {
      // Only one 2iC per squad
      if (otherModelsInSquad.any((m) => m.command == Command.secondIC)) {
        return false;
      }
    }

    // Check roster-level constraints
    if (newCommandLevel == Command.co) {
      // Only one CO per roster
      if (allOtherModels.any((m) => m.command == Command.co)) {
        return false;
      }
      // CO cannot coexist with 1iC
      if (otherModelsInSquad.any((m) => m.command == Command.firstIC)) {
        return false;
      }
    }

    if (newCommandLevel == Command.xo) {
      // Only one XO per roster
      if (allOtherModels.any((m) => m.command == Command.xo)) {
        return false;
      }
      // XO cannot coexist with 1iC
      if (otherModelsInSquad.any((m) => m.command == Command.firstIC)) {
        return false;
      }
    }

    return true;
  }

  /// Gets a user-friendly message explaining why a command level cannot be assigned.
  String? getValidationMessage({
    required Model model,
    required Command newCommandLevel,
    required Squad squad,
    required List<Squad> allSquads,
  }) {
    if (newCommandLevel == Command.none) {
      return null;
    }

    // Check role constraint first
    if (newCommandLevel == Command.firstIC ||
        newCommandLevel == Command.co ||
        newCommandLevel == Command.xo) {
      if (!model.roles.contains(squad.primaryRole)) {
        final commandName = newCommandLevel == Command.firstIC
            ? '1iC'
            : (newCommandLevel == Command.co ? 'CO' : 'XO');
        return 'This unit does not have the required role (${squad.primaryRole.abbreviation}) to be a $commandName.';
      }
    }

    final otherModelsInSquad = squad.models
        .where((m) => m.id != model.id)
        .toList();
    final allOtherModels = allSquads
        .expand((s) => s.models)
        .where((m) => m.id != model.id)
        .toList();

    if (newCommandLevel == Command.firstIC) {
      if (otherModelsInSquad.any((m) => m.command == Command.firstIC)) {
        return 'This squad already has a 1iC.';
      }
      if (otherModelsInSquad.any(
        (m) => m.command == Command.co || m.command == Command.xo,
      )) {
        return 'A squad cannot have a 1iC alongside a CO or XO.';
      }
    }

    if (newCommandLevel == Command.secondIC) {
      if (otherModelsInSquad.any((m) => m.command == Command.secondIC)) {
        return 'This squad already has a 2iC.';
      }
    }

    if (newCommandLevel == Command.co) {
      if (allOtherModels.any((m) => m.command == Command.co)) {
        return 'The roster already has a CO.';
      }
      if (otherModelsInSquad.any((m) => m.command == Command.firstIC)) {
        return 'A squad cannot have a 1iC alongside a CO.';
      }
    }

    if (newCommandLevel == Command.xo) {
      if (allOtherModels.any((m) => m.command == Command.xo)) {
        return 'The roster already has an XO.';
      }
      if (otherModelsInSquad.any((m) => m.command == Command.firstIC)) {
        return 'A squad cannot have a 1iC alongside an XO.';
      }
    }

    return null;
  }

  /// Gets a list of models whose command level should be cleared to Command.none
  /// when assigning the new command level to the specified model.
  ///
  /// This enables automatic replacement behavior:
  /// - Assigning 1iC clears any existing 1iC, CO, or XO in the squad
  /// - Assigning 2iC clears any existing 2iC in the squad
  /// - Assigning CO clears any existing CO in the roster and any 1iC in the squad
  /// - Assigning XO clears any existing XO in the roster and any 1iC in the squad
  List<({Squad squad, Model model})> getModelsToClear({
    required Model model,
    required Command newCommandLevel,
    required Squad squad,
    required List<Squad> allSquads,
  }) {
    final modelsToClear = <({Squad squad, Model model})>[];

    if (newCommandLevel == Command.none) {
      return modelsToClear;
    }

    // Helper to find which squad a model belongs to
    Squad? findSquadForModel(Model m) {
      for (final s in allSquads) {
        if (s.models.any((model) => model.id == m.id)) {
          return s;
        }
      }
      return null;
    }

    final otherModelsInSquad = squad.models
        .where((m) => m.id != model.id)
        .toList();

    final allOtherModels = allSquads
        .expand((s) => s.models)
        .where((m) => m.id != model.id)
        .toList();

    if (newCommandLevel == Command.firstIC) {
      // Clear any existing 1iC in the squad
      for (final m in otherModelsInSquad) {
        if (m.command == Command.firstIC) {
          modelsToClear.add((squad: squad, model: m));
        }
      }
      // Clear any CO or XO in the squad (1iC cannot coexist with CO/XO)
      for (final m in otherModelsInSquad) {
        if (m.command == Command.co || m.command == Command.xo) {
          modelsToClear.add((squad: squad, model: m));
        }
      }
    }

    if (newCommandLevel == Command.secondIC) {
      // Clear any existing 2iC in the squad
      for (final m in otherModelsInSquad) {
        if (m.command == Command.secondIC) {
          modelsToClear.add((squad: squad, model: m));
        }
      }
    }

    if (newCommandLevel == Command.co) {
      // Clear any existing CO in the roster
      for (final m in allOtherModels) {
        if (m.command == Command.co) {
          final s = findSquadForModel(m);
          if (s != null) {
            modelsToClear.add((squad: s, model: m));
          }
        }
      }
      // Clear any 1iC in the squad (CO cannot coexist with 1iC)
      for (final m in otherModelsInSquad) {
        if (m.command == Command.firstIC) {
          modelsToClear.add((squad: squad, model: m));
        }
      }
    }

    if (newCommandLevel == Command.xo) {
      // Clear any existing XO in the roster
      for (final m in allOtherModels) {
        if (m.command == Command.xo) {
          final s = findSquadForModel(m);
          if (s != null) {
            modelsToClear.add((squad: s, model: m));
          }
        }
      }
      // Clear any 1iC in the squad
      for (final m in otherModelsInSquad) {
        if (m.command == Command.firstIC) {
          modelsToClear.add((squad: squad, model: m));
        }
      }
    }

    return modelsToClear;
  }
}
