import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/pages/roster/models/combat_group.dart';
import 'package:gearforce/src/pages/roster/models/squad.dart';
import 'package:gearforce/src/pages/roster/models/subfaction.dart';
import 'package:gearforce/src/pages/roster/models/unit.dart';
import 'package:meta/meta.dart';
import 'package:gearforce/src/pages/roster/models/faction.dart';

part 'roster_event.dart';
part 'roster_state.dart';

class RosterBloc extends Bloc<RosterEvent, RosterState> {
  RosterBloc() : super(RosterInitial()) {
    on<AddCombatGroup>((event, emit) {
      final updatedCombatGroups = List<CombatGroup>.from(state.combatGroups)
        ..add(event.combatGroup);
      emit(
        RosterUpdated(
          state.playerName,
          state.rosterName,
          updatedCombatGroups,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
        ),
      );
    });

    on<UpdatePlayerName>((event, emit) {
      emit(
        RosterUpdated(
          event.playerName,
          state.rosterName,
          state.combatGroups,
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
          state.combatGroups,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
        ),
      );
    });

    on<AddSquad>((event, emit) {
      final updatedCombatGroups = state.combatGroups.map((cg) {
        if (cg.id == event.combatGroupId) {
          return cg.copyWith(
            squads: List<Squad>.from(cg.squads)..add(event.squad),
          );
        }
        return cg;
      }).toList();
      emit(
        RosterUpdated(
          state.playerName,
          state.rosterName,
          updatedCombatGroups,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
        ),
      );
    });

    on<AddUnit>((event, emit) {
      final updatedCombatGroups = state.combatGroups.map((cg) {
        if (cg.id == event.combatGroupId) {
          final updatedSquads = cg.squads.map(
            (squad) {
              if (squad.id == event.squadId) {
                return squad.copyWith(
                  units: List<Unit>.from(squad.units)..add(event.unit),
                );
              }
              return squad;
            },
          ).toList();
          return cg.copyWith(squads: updatedSquads);
        }
        return cg;
      }).toList();
      emit(
        RosterUpdated(
          state.playerName,
          state.rosterName,
          updatedCombatGroups,
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
          state.combatGroups,
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
          state.combatGroups,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: event.subfaction,
        ),
      );
    });
  }
}
