import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/faction.dart';
import 'package:gearforce/src/models/roster/rules/rule_set.dart';
import 'package:gearforce/src/models/roster/squad/squad.dart';
import 'package:gearforce/src/models/roster/squad/squad_level.dart';
import 'package:gearforce/src/models/roster/subfaction.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_level.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/command.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:gearforce/src/models/roster/unit/model_base.dart';
import 'package:gearforce/src/models/roster/unit/variant.dart';
import 'package:gearforce/src/pages/roster/bloc/squad_state.dart';
import 'package:gearforce/src/predefined/rules/get_subfaction_rule_set.dart';
import 'package:meta/meta.dart';

part 'roster_event.dart';
part 'roster_state.dart';
part 'squad_event.dart';

class RosterBloc extends Bloc<RosterEvent, RosterState> {
  RosterBloc() : super(RosterInitial()) {
    on<UpdatePlayerName>((event, emit) {
      emit(state.copyWith(playerName: event.playerName));
    });
    on<UpdateRosterName>((event, emit) {
      emit(state.copyWith(rosterName: event.rosterName));
    });
    on<AddNewSquad>(_onAddNewSquad);
    on<RemoveSquad>(_onRemoveSquad);
    on<AddModel>(_onAddModel);
    on<UpdateSquadLevel>(_onUpdateSquadLevel);
    on<UpdateModelLevel>(_onUpdateModelLevel);
    on<UpdateModelIsDuelist>(_onUpdateModelIsDuelist);
    on<UpdateModelCommandLevel>(_onUpdateModelCommand);
    on<UpdateFaction>(_onUpdateFaction);
    on<UpdateSubfaction>(_onUpdateSubFaction);
    on<UpdateSquads>(_onUpdateSquads);
    on<UpdateSquad>(_onUpdateSquad);
    on<UpdateSquadRoles>(_onUpdateSquadRoles);
  }

  void _onAddNewSquad(AddNewSquad event, Emitter<RosterState> emit) {
    int newId;

    // Ensure the squad id is unique
    do {
      newId = nextId;
    } while (state.squads.any((squad) => squad.id == newId));

    final newSquad = Squad(
      id: newId,
      name: event.name,
      primaryRole: event.primaryRole,
      secondaryRole: event.secondaryRole,
      level: event.level,
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
    final model = Model(id: nextId, base: event.base, variant: event.variant);
    final updatedSquad = event.squad.copyWith(
      models: [...event.squad.models, model],
    );
    final updatedSquadState = state.squadState.updateSquad(updatedSquad);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void _onUpdateSquadLevel(UpdateSquadLevel event, Emitter<RosterState> emit) {
    final updatedSquad = event.squad.copyWith(level: event.level);
    final updateSquadState = state.squadState.updateSquad(updatedSquad);
    emit(state.copyWith(squadState: updateSquadState));
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
    // TODO Implement
  }

  void _onUpdateModelCommand(
    UpdateModelCommandLevel event,
    Emitter<RosterState> emit,
  ) {
    // TODO Implement
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
        ruleSet: getSubfactionRuleSet(subfaction),
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
        ruleSet: getSubfactionRuleSet(event.subfaction),
      ),
    );
  }

  void _onUpdateSquads(UpdateSquads event, Emitter<RosterState> emit) {
    final updatedSquadState = state.squadState.copyWith(squads: event.squads);
    emit(state.copyWith(squadState: updatedSquadState));
  }

  void _onUpdateSquad(UpdateSquad event, Emitter<RosterState> emit) {
    final updatedSquadState = state.squadState.updateSquadByName(
      event.updatedSquad.name,
      event.updatedSquad,
    );
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
    final updatedSquadState = state.squadState.updateSquadByName(
      event.squad.name,
      validatedSquad,
    );

    emit(state.copyWith(squadState: updatedSquadState));
  }

  static int _nextId = 0;
  static int get nextId {
    _nextId++;
    return _nextId;
  }
}
