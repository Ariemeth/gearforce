import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/pages/roster/models/squad.dart';
import 'package:gearforce/src/pages/roster/models/subfaction.dart';
import 'package:gearforce/src/pages/roster/models/core_unit.dart';
import 'package:meta/meta.dart';
import 'package:gearforce/src/pages/roster/models/faction.dart';

part 'roster_event.dart';
part 'roster_state.dart';

class RosterBloc extends Bloc<RosterEvent, RosterState> {
  RosterBloc() : super(RosterInitial()) {
    on<UpdatePlayerName>((event, emit) {
      emit(
        RosterUpdated(
          event.playerName,
          state.rosterName,
          state.squads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
        ),
      );
    });

    on<UpdateRosterName>((event, emit) {
      emit(
        RosterUpdated(
          state.playerName,
          event.rosterName,
          state.squads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
        ),
      );
    });

    on<AddSquad>((event, emit) {
      final updatedSquads = List<Squad>.from(state.squads)..add(event.squad);
      emit(
        RosterUpdated(
          state.playerName,
          state.rosterName,
          updatedSquads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
        ),
      );
    });

    on<AddUnit>((event, emit) {
      final updatedSquads = state.squads.map((squad) {
        if (squad.name == event.squadName) {
          // Use squadName instead of squadId
          return squad.copyWith(
            units: List<CoreUnit>.from(squad.units)..add(event.unit),
          );
        }
        return squad;
      }).toList();
      emit(
        RosterUpdated(
          state.playerName,
          state.rosterName,
          updatedSquads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
        ),
      );
    });

    on<UpdateFactionEvent>((event, emit) {
      emit(
        RosterUpdated(
          state.playerName,
          state.rosterName,
          state.squads,
          selectedFaction: event.faction,
          selectedSubfaction: null, // Reset subfaction when faction changes
        ),
      );
    });

    on<UpdateSubfactionEvent>((event, emit) {
      emit(
        RosterUpdated(
          state.playerName,
          state.rosterName,
          state.squads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: event.subfaction,
        ),
      );
    });

    on<UpdateSquads>((event, emit) {
      emit(
        RosterUpdated(
          state.playerName,
          state.rosterName,
          event.squads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
        ),
      );
    });

    on<UpdateSquad>((event, emit) {
      final updatedSquads = state.squads.map((squad) {
        if (squad.name == event.updatedSquad.name) {
          // Use name instead of id
          return event.updatedSquad;
        }
        return squad;
      }).toList();

      emit(
        RosterUpdated(
          state.playerName,
          state.rosterName,
          updatedSquads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
        ),
      );
    });
  }
}
