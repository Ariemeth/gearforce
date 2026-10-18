import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/rule_set.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/attribute/unit_level.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/command.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/model_base.dart';
import 'package:gearforce/domain/entities/unit/model_upgrade.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/get_subfaction_rule_set.dart';
import 'package:gearforce/domain/rules/roster_rule_engine.dart';
import 'package:gearforce/domain/rules/squad_rule_engine.dart';
import 'package:gearforce/features/roster/bloc/squad_state.dart';
import 'package:meta/meta.dart';

part 'roster_state.dart';

class RosterCubit extends Cubit<RosterState> {
  final UnitRepository unitRepository;
  int _nextSquadNumber = 0;
  int _nextModelId = 0;

  RosterCubit(this.unitRepository) : super(RosterInitial(unitRepository));

  void updatePlayerName(String playerName) {
    emit(state.copyWith(playerName: playerName));
  }

  void updateRosterName(String rosterName) {
    emit(state.copyWith(rosterName: rosterName));
  }

  void addNewSquad({
    required String name,
    Role primaryRole = Role.gp,
    Role? secondaryRole,
  }) {
    _nextSquadNumber++;
    int newId = _nextSquadNumber;

    // Ensure the squad id is unique
    while (state.squads.any((squad) => squad.id == newId)) {
      _nextSquadNumber++;
      newId = _nextSquadNumber;
    }

    final newSquad = Squad(
      id: newId,
      name: name,
      primaryRole: primaryRole,
      secondaryRole: secondaryRole,
      models: const [],
      upgrades: const [],
    );

    final updatedSquadState = state.squadState.addSquad(newSquad);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void removeSquad(Squad squad) {
    final updatedSquadState = state.squadState.removeSquad(squad);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void duplicateSquad({required Squad squad, required String name}) {
    final updatedSquads = RosterRuleEngine.duplicateSquad(
      squadToDuplicate: squad,
      newSquadName: name,
      currentSquads: state.squads,
      ruleSet: state.ruleSet,
      nextSquadIdGenerator: () {
        _nextSquadNumber++;
        while (state.squads.any((s) => s.id == _nextSquadNumber)) {
          _nextSquadNumber++;
        }
        return _nextSquadNumber;
      },
      nextModelIdGenerator: () {
        _nextModelId++;
        return _nextModelId;
      },
    );

    emit(
      state.copyWith(
        squadState: state.squadState.copyWith(squads: updatedSquads),
      ),
    );
  }

  void addModel({
    required Squad squad,
    required ModelBase base,
    required Variant variant,
  }) {
    // Only auto-assign 1iC if the squad needs a required command AND the new model has the primary role
    final needsRequiredCommand = !SquadRuleEngine.hasRequiredCommand(
      squad.models,
      state.ruleSet,
    );
    final modelHasPrimaryRole = base.roles.contains(squad.primaryRole);
    final shouldAssignFirstIc = needsRequiredCommand && modelHasPrimaryRole;

    final newModel = Model(
      id: _nextModelId + 1,
      base: base,
      variant: variant,
      command: shouldAssignFirstIc ? Command.firstIC : Command.none,
    );

    if (!state.ruleSet.canAddUnitToSquad(squad: squad, unit: newModel)) {
      return;
    }

    _nextModelId++;

    final updatedSquad = squad.copyWith(models: [...squad.models, newModel]);
    final updatedSquadState = state.squadState.updateSquad(updatedSquad);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void removeModel({required Squad squad, required Model model}) {
    final squadAfterRemoval = squad.copyWith(
      models: [
        for (final m in squad.models)
          if (m.id != model.id) m,
      ],
    );

    final updatedSquads = [
      for (final s in state.squads) s.id == squad.id ? squadAfterRemoval : s,
    ];

    final squadIndex = updatedSquads.indexWhere((s) => s.id == squad.id);
    if (squadIndex != -1) {
      updatedSquads[squadIndex] = SquadRuleEngine.ensureRequiredCommand(
        squad: updatedSquads[squadIndex],
        allSquads: updatedSquads,
        ruleSet: state.ruleSet,
      );
    }

    emit(
      state.copyWith(
        squadState: state.squadState.copyWith(squads: updatedSquads),
      ),
    );
  }

  void duplicateModel({required Squad squad, required Model model}) {
    _nextModelId++;

    var duplicatedModel = model.copyWith(
      id: _nextModelId,
      command: Command.none,
      level: UnitLevel.regular,
      isDuelist: false,
    );

    final canCopyLevel = state.ruleSet.canAssignUnitLevel(
      model: duplicatedModel,
      newLevel: model.level,
      squad: squad,
      allSquads: state.squads,
    );

    if (canCopyLevel) {
      duplicatedModel = duplicatedModel.copyWith(level: model.level);
    }

    final canCopyDuelist =
        model.isDuelist &&
        state.ruleSet.canAssignDuelist(
          model: duplicatedModel,
          newDuelistStatus: true,
          squad: squad,
          allSquads: state.squads,
        );

    if (canCopyDuelist) {
      duplicatedModel = duplicatedModel.copyWith(isDuelist: true);
    }

    if (!state.ruleSet.canAddUnitToSquad(squad: squad, unit: duplicatedModel)) {
      return;
    }

    final updatedSquad = squad.copyWith(
      models: [...squad.models, duplicatedModel],
    );

    emit(
      state.copyWith(squadState: state.squadState.updateSquad(updatedSquad)),
    );
  }

  void updateModelLevel({
    required Squad squad,
    required Model model,
    required UnitLevel level,
  }) {
    // Get the current model from the squad state (not from parameters, which might be stale)
    final currentModel = squad.models.firstWhere(
      (m) => m.id == model.id,
      orElse: () => model,
    );

    final updatedSquad = SquadRuleEngine.resolveLevelChange(
      currentModel: currentModel,
      newLevel: level,
      squad: squad,
      allSquads: state.squads,
      ruleSet: state.ruleSet,
    );

    if (updatedSquad == null) {
      return;
    }

    emit(
      state.copyWith(squadState: state.squadState.updateSquad(updatedSquad)),
    );
  }

  void updateModelIsDuelist({
    required Squad squad,
    required Model model,
    required bool isDuelist,
  }) {
    final updatedSquad = squad.copyWith(
      models: [
        for (final m in squad.models)
          m.id == model.id ? m.copyWith(isDuelist: isDuelist) : m,
      ],
    );

    emit(
      state.copyWith(squadState: state.squadState.updateSquad(updatedSquad)),
    );
  }

  void updateModelCommandLevel({
    required Squad squad,
    required Model model,
    required Command commandLevel,
  }) {
    final updatedSquads = SquadRuleEngine.resolveCommandLevelChange(
      model: model,
      newCommandLevel: commandLevel,
      squad: squad,
      allSquads: state.squads,
      ruleSet: state.ruleSet,
    );

    if (updatedSquads == null) {
      return;
    }

    emit(
      state.copyWith(
        squadState: state.squadState.copyWith(squads: updatedSquads),
      ),
    );
  }

  void updateModelUpgradeEnabled({
    required Squad squad,
    required Model model,
    required ModelUpgrade upgrade,
    required bool enabled,
  }) {
    final currentModel = squad.models.firstWhere(
      (m) => m.id == model.id,
      orElse: () => model,
    );

    final updatedModel = enabled
        ? currentModel.setModelUpgradeEnabled(upgrade: upgrade)
        : currentModel.removeModelUpgrade(upgrade);

    final updatedSquad = squad.copyWith(
      models: [
        for (final m in squad.models)
          m.id == currentModel.id ? updatedModel : m,
      ],
    );

    emit(
      state.copyWith(squadState: state.squadState.updateSquad(updatedSquad)),
    );
  }

  void updateFaction(Faction faction) {
    if (faction == state.selectedFaction) {
      // No change in faction, do not emit a new state
      return;
    }
    final subfaction = faction.subfactions.first;
    emit(
      state.copyWith(
        squadState: const SquadState(squads: []), // Clear squads
        selectedFaction: faction,
        selectedSubfaction: subfaction,
        ruleSet: getSubfactionRuleSet(subfaction, unitRepository),
      ),
    );
  }

  void updateSubfaction(Subfaction subfaction) {
    if (subfaction == state.selectedSubfaction) {
      // No change in subfaction, do not emit a new state
      return;
    }
    emit(
      state.copyWith(
        selectedSubfaction: subfaction,
        ruleSet: getSubfactionRuleSet(subfaction, unitRepository),
      ),
    );
  }

  void renameSquad({required Squad squad, required String newName}) {
    final renamedSquad = squad.copyWith(name: newName);
    final updatedSquadState = state.squadState.updateSquad(renamedSquad);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void updateSquads(List<Squad> squads) {
    final updatedSquadState = state.squadState.copyWith(squads: squads);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void updateSquad(Squad updatedSquad) {
    final updatedSquadState = state.squadState.updateSquad(updatedSquad);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void updateSquadRoles({
    required Squad squad,
    required Role primaryRole,
    Role? secondaryRole,
  }) {
    // Create updated squad with new roles
    final updatedSquad = squad.copyWith(
      primaryRole: primaryRole,
      secondaryRole: secondaryRole,
      allowSecondaryRoleToBeNull: secondaryRole == null,
    );

    // Validate and filter units based on new roles
    final validatedSquad = Squad.filterValidSquadUnits(updatedSquad);
    final updatedSquadState = state.squadState.updateSquad(validatedSquad);

    emit(state.copyWith(squadState: updatedSquadState));
  }

  void reorderModel({
    required Squad squad,
    required int oldIndex,
    required int newIndex,
  }) {
    final models = List<Model>.from(squad.models);

    if (oldIndex < 0 ||
        oldIndex >= models.length ||
        newIndex < 0 ||
        newIndex > models.length) {
      return;
    }

    final targetIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;

    if (oldIndex == targetIndex) {
      return;
    }

    final model = models.removeAt(oldIndex);
    models.insert(targetIndex, model);

    final updatedSquad = squad.copyWith(models: models);
    final updatedSquadState = state.squadState.updateSquad(updatedSquad);

    emit(state.copyWith(squadState: updatedSquadState));
  }

  void reorderSquad({required int oldIndex, required int newIndex}) {
    final squads = List<Squad>.from(state.squads);

    if (oldIndex < 0 ||
        oldIndex >= squads.length ||
        newIndex < 0 ||
        newIndex > squads.length) {
      return;
    }

    final targetIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;

    if (oldIndex == targetIndex) {
      return;
    }

    final squad = squads.removeAt(oldIndex);
    squads.insert(targetIndex, squad);

    final updatedSquadState = state.squadState.copyWith(squads: squads);
    emit(state.copyWith(squadState: updatedSquadState));
  }
}
