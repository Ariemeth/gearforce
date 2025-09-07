import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/faction.dart';
import 'package:gearforce/src/models/roster/rules/rule_set.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/models/roster/subfaction.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';
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

    on<AddSquad>((event, emit) {
      final updatedSquadState = state.squadState.addSquad(event.squad);
      emit(state.copyWith(squadState: updatedSquadState));
    });

    on<RemoveSquad>((event, emit) {
      final updatedSquadState = state.squadState.removeSquad(event.squad);
      emit(state.copyWith(squadState: updatedSquadState));
    });

    on<AddModel>((event, emit) {
      final updatedSquad = event.squad.copyWith(
        models: [...event.squad.models, event.model],
      );
      final updatedSquadState = state.squadState.updateSquad(
        event.squad,
        updatedSquad,
      );
      emit(state.copyWith(squadState: updatedSquadState));
    });

    on<UpdateFaction>((event, emit) {
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
    });

    on<UpdateSubfaction>((event, emit) {
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
    });

    on<UpdateSquads>((event, emit) {
      final updatedSquadState = state.squadState.copyWith(squads: event.squads);
      emit(state.copyWith(squadState: updatedSquadState));
    });

    on<UpdateSquad>((event, emit) {
      final updatedSquadState = state.squadState.updateSquadByName(
        event.updatedSquad.name,
        event.updatedSquad,
      );
      emit(state.copyWith(squadState: updatedSquadState));
    });

    on<UpdateSquadRoles>((event, emit) {
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
    });
  }
}
