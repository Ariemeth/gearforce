import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/models/roster/subfaction.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:meta/meta.dart';
import 'package:gearforce/src/models/roster/faction.dart';

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

    on<AddModel>((event, emit) {
      final updatedSquads = state.squads.map((squad) {
        if (squad.name == event.squadName) {
          return squad.copyWith(
            models: List<Model>.from(squad.models)..add(event.model),
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
          selectedSubfaction: null,
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
