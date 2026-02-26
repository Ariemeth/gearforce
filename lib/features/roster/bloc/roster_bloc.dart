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
import 'package:gearforce/domain/entities/unit/variant.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/features/roster/bloc/squad_state.dart';
import 'package:gearforce/data/static/rules/get_subfaction_rule_set.dart';
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
    on<AddModel>(_onAddModel);
    on<RemoveModel>(_onRemoveModel);
    on<UpdateModelLevel>(_onUpdateModelLevel);
    on<UpdateModelIsDuelist>(_onUpdateModelIsDuelist);
    on<UpdateModelCommandLevel>(_onUpdateModelCommand);
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

    final updatedSquads = List<Squad>.from(state.squads)..add(newSquad);
    final updatedSquadState = state.squadState.copyWith(squads: updatedSquads);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void _onRemoveSquad(RemoveSquad event, Emitter<RosterState> emit) {
    final updatedSquadState = state.squadState.removeSquad(event.squad);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void _onAddModel(AddModel event, Emitter<RosterState> emit) {
    final shouldAssignFirstIc = !_hasRequiredCommand(event.squad.models);
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
    final updatedSquad = event.squad.copyWith(
      models: [
        for (final m in event.squad.models)
          if (m.id != event.model.id) m,
      ],
    );
    emit(
      state.copyWith(squadState: state.squadState.updateSquad(updatedSquad)),
    );
  }

  void _onUpdateModelLevel(UpdateModelLevel event, Emitter<RosterState> emit) {
    final updatedSquad = event.squad.copyWith(
      models: [
        for (final m in event.squad.models)
          m.id == event.model.id ? m.copyWith(level: event.level) : m,
      ],
    );

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
    // Get models that need to be cleared to Command.none
    final modelsToClear = state.ruleSet.getModelsToClearForCommandLevel(
      model: event.model,
      newCommandLevel: event.commandLevel,
      squad: event.squad,
      allSquads: state.squads,
    );

    // Start with the current squads
    var updatedSquads = List<Squad>.from(state.squads);
    final affectedSquadIds = <int>{event.squad.id};

    // First, clear conflicting command levels
    for (final entry in modelsToClear) {
      affectedSquadIds.add(entry.squad.id);
      final squadIndex = updatedSquads.indexWhere(
        (s) => s.id == entry.squad.id,
      );
      if (squadIndex != -1) {
        final squad = updatedSquads[squadIndex];
        final updatedModels = squad.models.map((m) {
          return m.id == entry.model.id ? m.copyWith(command: Command.none) : m;
        }).toList();
        updatedSquads[squadIndex] = squad.copyWith(models: updatedModels);
      }
    }

    // Then, apply the new command level to the target model
    final targetSquadIndex = updatedSquads.indexWhere(
      (s) => s.id == event.squad.id,
    );
    if (targetSquadIndex != -1) {
      final squad = updatedSquads[targetSquadIndex];
      final updatedModels = squad.models.map((m) {
        return m.id == event.model.id
            ? m.copyWith(command: event.commandLevel)
            : m;
      }).toList();
      updatedSquads[targetSquadIndex] = squad.copyWith(models: updatedModels);
    }

    // Ensure squads maintain required command presence
    for (final squadId in affectedSquadIds) {
      final squadIndex = updatedSquads.indexWhere((s) => s.id == squadId);
      if (squadIndex != -1) {
        updatedSquads[squadIndex] = _ensureRequiredCommand(
          updatedSquads[squadIndex],
        );
      }
    }

    emit(
      state.copyWith(
        squadState: state.squadState.copyWith(squads: updatedSquads),
      ),
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

  bool _hasRequiredCommand(Iterable<Model> models) {
    return models.any(
      (model) =>
          model.command == Command.firstIC ||
          model.command == Command.co ||
          model.command == Command.xo,
    );
  }

  Squad _ensureRequiredCommand(Squad squad) {
    if (_hasRequiredCommand(squad.models)) {
      return squad;
    }

    final index = squad.models.indexWhere(
      (model) => model.command == Command.none,
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
}
