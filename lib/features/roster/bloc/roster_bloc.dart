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

part 'roster_event.dart';
part 'roster_state.dart';
part 'squad_event.dart';

class RosterBloc extends Bloc<RosterEvent, RosterState> {
  final UnitRepository unitRepository;
  int _nextSquadNumber = 0;
  int _nextModelId = 0;

  RosterBloc(this.unitRepository) : super(RosterInitial(unitRepository)) {
    on<UpdatePlayerName>((event, emit) {
      emit(state.copyWith(playerName: event.playerName));
    });
    on<UpdateRosterName>((event, emit) {
      emit(state.copyWith(rosterName: event.rosterName));
    });
    on<AddNewSquad>(_onAddNewSquad);
    on<RemoveSquad>(_onRemoveSquad);
    on<DuplicateSquad>(_onDuplicateSquad);
    on<AddModel>(_onAddModel);
    on<RemoveModel>(_onRemoveModel);
    on<DuplicateModel>(_onDuplicateModel);
    on<UpdateModelLevel>(_onUpdateModelLevel);
    on<UpdateModelIsDuelist>(_onUpdateModelIsDuelist);
    on<UpdateModelCommandLevel>(_onUpdateModelCommand);
    on<UpdateModelUpgradeEnabled>(_onUpdateModelUpgradeEnabled);
    on<UpdateFaction>(_onUpdateFaction);
    on<UpdateSubfaction>(_onUpdateSubFaction);
    on<RenameSquad>(_onRenameSquad);
    on<UpdateSquads>(_onUpdateSquads);
    on<UpdateSquad>(_onUpdateSquad);
    on<UpdateSquadRoles>(_onUpdateSquadRoles);
    on<ReorderModel>(_onReorderModel);
    on<ReorderSquad>(_onReorderSquad);
  }

  void _onAddNewSquad(AddNewSquad event, Emitter<RosterState> emit) {
    _nextSquadNumber++;
    int newId = _nextSquadNumber;

    // Ensure the squad id is unique
    while (state.squads.any((squad) => squad.id == newId)) {
      _nextSquadNumber++;
      newId = _nextSquadNumber;
    }

    final newSquad = Squad(
      id: newId,
      name: event.name,
      primaryRole: event.primaryRole,
      secondaryRole: event.secondaryRole,
      models: const [],
      upgrades: const [],
    );

    final updatedSquadState = state.squadState.addSquad(newSquad);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void _onRemoveSquad(RemoveSquad event, Emitter<RosterState> emit) {
    final updatedSquadState = state.squadState.removeSquad(event.squad);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void _onDuplicateSquad(DuplicateSquad event, Emitter<RosterState> emit) {
    final updatedSquads = RosterRuleEngine.duplicateSquad(
      squadToDuplicate: event.squad,
      newSquadName: event.name,
      currentSquads: state.squads,
      ruleSet: state.ruleSet,
      nextSquadIdGenerator: () {
        _nextSquadNumber++;
        while (state.squads.any((squad) => squad.id == _nextSquadNumber)) {
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

  void _onAddModel(AddModel event, Emitter<RosterState> emit) {
    // Only auto-assign 1iC if the squad needs a required command AND the new model has the primary role
    final needsRequiredCommand = !SquadRuleEngine.hasRequiredCommand(
      event.squad.models,
      state.ruleSet,
    );
    final modelHasPrimaryRole = event.base.roles.contains(
      event.squad.primaryRole,
    );
    final shouldAssignFirstIc = needsRequiredCommand && modelHasPrimaryRole;

    final newModel = Model(
      id: _nextModelId + 1,
      base: event.base,
      variant: event.variant,
      command: shouldAssignFirstIc ? Command.firstIC : Command.none,
    );

    if (!state.ruleSet.canAddUnitToSquad(squad: event.squad, unit: newModel)) {
      return;
    }

    _nextModelId++;

    final updatedSquad = event.squad.copyWith(
      models: [...event.squad.models, newModel],
    );
    final updatedSquadState = state.squadState.updateSquad(updatedSquad);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void _onRemoveModel(RemoveModel event, Emitter<RosterState> emit) {
    final squadAfterRemoval = event.squad.copyWith(
      models: [
        for (final m in event.squad.models)
          if (m.id != event.model.id) m,
      ],
    );

    final updatedSquads = [
      for (final squad in state.squads)
        squad.id == event.squad.id ? squadAfterRemoval : squad,
    ];

    final squadIndex = updatedSquads.indexWhere((s) => s.id == event.squad.id);
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

  void _onDuplicateModel(DuplicateModel event, Emitter<RosterState> emit) {
    _nextModelId++;

    var duplicatedModel = event.model.copyWith(
      id: _nextModelId,
      command: Command.none,
      level: UnitLevel.regular,
      isDuelist: false,
    );

    final canCopyLevel = state.ruleSet.canAssignUnitLevel(
      model: duplicatedModel,
      newLevel: event.model.level,
      squad: event.squad,
      allSquads: state.squads,
    );

    if (canCopyLevel) {
      duplicatedModel = duplicatedModel.copyWith(level: event.model.level);
    }

    final canCopyDuelist =
        event.model.isDuelist &&
        state.ruleSet.canAssignDuelist(
          model: duplicatedModel,
          newDuelistStatus: true,
          squad: event.squad,
          allSquads: state.squads,
        );

    if (canCopyDuelist) {
      duplicatedModel = duplicatedModel.copyWith(isDuelist: true);
    }

    if (!state.ruleSet.canAddUnitToSquad(
      squad: event.squad,
      unit: duplicatedModel,
    )) {
      return;
    }

    final updatedSquad = event.squad.copyWith(
      models: [...event.squad.models, duplicatedModel],
    );

    emit(
      state.copyWith(squadState: state.squadState.updateSquad(updatedSquad)),
    );
  }

  void _onUpdateModelLevel(UpdateModelLevel event, Emitter<RosterState> emit) {
    // Get the current model from the squad state (not from the event, which might be stale)
    final currentModel = event.squad.models.firstWhere(
      (m) => m.id == event.model.id,
      orElse: () => event.model,
    );

    final updatedSquad = SquadRuleEngine.resolveLevelChange(
      currentModel: currentModel,
      newLevel: event.level,
      squad: event.squad,
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

  void _onUpdateModelIsDuelist(
    UpdateModelIsDuelist event,
    Emitter<RosterState> emit,
  ) {
    final updatedSquad = event.squad.copyWith(
      models: [
        for (final m in event.squad.models)
          m.id == event.model.id ? m.copyWith(isDuelist: event.isDuelist) : m,
      ],
    );

    emit(
      state.copyWith(squadState: state.squadState.updateSquad(updatedSquad)),
    );
  }

  void _onUpdateModelCommand(
    UpdateModelCommandLevel event,
    Emitter<RosterState> emit,
  ) {
    final updatedSquads = SquadRuleEngine.resolveCommandLevelChange(
      model: event.model,
      newCommandLevel: event.commandLevel,
      squad: event.squad,
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

  void _onUpdateModelUpgradeEnabled(
    UpdateModelUpgradeEnabled event,
    Emitter<RosterState> emit,
  ) {
    final currentModel = event.squad.models.firstWhere(
      (m) => m.id == event.model.id,
      orElse: () => event.model,
    );

    final updatedModel = event.enabled
        ? currentModel.setModelUpgradeEnabled(upgrade: event.upgrade)
        : currentModel.removeModelUpgrade(event.upgrade);

    final updatedSquad = event.squad.copyWith(
      models: [
        for (final model in event.squad.models)
          model.id == currentModel.id ? updatedModel : model,
      ],
    );

    emit(
      state.copyWith(squadState: state.squadState.updateSquad(updatedSquad)),
    );
  }

  void _onUpdateFaction(UpdateFaction event, Emitter<RosterState> emit) {
    if (event.faction == state.selectedFaction) {
      // No change in faction, do not emit a new state
      return;
    }
    final subfaction = event.faction.subfactions.first;
    emit(
      state.copyWith(
        squadState: const SquadState(squads: []), // Clear squads
        selectedFaction: event.faction,
        selectedSubfaction: subfaction,
        ruleSet: getSubfactionRuleSet(subfaction, unitRepository),
      ),
    );
  }

  void _onUpdateSubFaction(UpdateSubfaction event, Emitter<RosterState> emit) {
    if (event.subfaction == state.selectedSubfaction) {
      // No change in subfaction, do not emit a new state
      return;
    }
    emit(
      state.copyWith(
        selectedSubfaction: event.subfaction,
        ruleSet: getSubfactionRuleSet(event.subfaction, unitRepository),
      ),
    );
  }

  void _onRenameSquad(RenameSquad event, Emitter<RosterState> emit) {
    final renamedSquad = event.squad.copyWith(name: event.newName);
    final updatedSquadState = state.squadState.updateSquad(renamedSquad);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void _onUpdateSquads(UpdateSquads event, Emitter<RosterState> emit) {
    final updatedSquadState = state.squadState.copyWith(squads: event.squads);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void _onUpdateSquad(UpdateSquad event, Emitter<RosterState> emit) {
    final updatedSquadState = state.squadState.updateSquad(event.updatedSquad);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void _onUpdateSquadRoles(UpdateSquadRoles event, Emitter<RosterState> emit) {
    // Create updated squad with new roles
    final updatedSquad = event.squad.copyWith(
      primaryRole: event.primaryRole,
      secondaryRole: event.secondaryRole,
      allowSecondaryRoleToBeNull: event.secondaryRole == null,
    );

    // Validate and filter units based on new roles
    final validatedSquad = Squad.filterValidSquadUnits(updatedSquad);
    final updatedSquadState = state.squadState.updateSquad(validatedSquad);

    emit(state.copyWith(squadState: updatedSquadState));
  }

  void _onReorderModel(ReorderModel event, Emitter<RosterState> emit) {
    final models = List<Model>.from(event.squad.models);

    // Handle reordering: remove from oldIndex and insert at newIndex
    if (event.oldIndex < event.newIndex) {
      // Moving down
      final model = models.removeAt(event.oldIndex);
      models.insert(event.newIndex - 1, model);
    } else {
      // Moving up
      final model = models.removeAt(event.oldIndex);
      models.insert(event.newIndex, model);
    }

    final updatedSquad = event.squad.copyWith(models: models);
    final updatedSquadState = state.squadState.updateSquad(updatedSquad);

    emit(state.copyWith(squadState: updatedSquadState));
  }

  void _onReorderSquad(ReorderSquad event, Emitter<RosterState> emit) {
    final squads = List<Squad>.from(state.squads);

    // Handle reordering: remove from oldIndex and insert at newIndex
    if (event.oldIndex < event.newIndex) {
      // Moving down
      final squad = squads.removeAt(event.oldIndex);
      squads.insert(event.newIndex - 1, squad);
    } else {
      // Moving up
      final squad = squads.removeAt(event.oldIndex);
      squads.insert(event.newIndex, squad);
    }

    final updatedSquadState = state.squadState.copyWith(squads: squads);
    emit(state.copyWith(squadState: updatedSquadState));
  }
}
