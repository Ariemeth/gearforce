import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/rules/rule_set.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/models/roster/subfaction.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:meta/meta.dart';
import 'package:gearforce/src/models/roster/faction.dart';
import 'package:gearforce/src/predefined/rules/get_subfaction_rule_set.dart';

part 'roster_event.dart';
part 'roster_state.dart';

class RosterBloc extends Bloc<RosterEvent, RosterState> {
  RosterBloc() : super(RosterInitial()) {
    on<UpdatePlayerName>((event, emit) {
      emit(
        RosterUpdated(
          playerName: event.playerName,
          rosterName: state.rosterName,
          squads: state.squads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
          ruleSet: state.ruleSet,
        ),
      );
    });

    on<UpdateRosterName>((event, emit) {
      emit(
        RosterUpdated(
          playerName: state.playerName,
          rosterName: event.rosterName,
          squads: state.squads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
          ruleSet: state.ruleSet,
        ),
      );
    });

    on<AddSquad>((event, emit) {
      final updatedSquads = List<Squad>.from(state.squads)..add(event.squad);
      emit(
        RosterUpdated(
          playerName: state.playerName,
          rosterName: state.rosterName,
          squads: updatedSquads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
          ruleSet: state.ruleSet,
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
          playerName: state.playerName,
          rosterName: state.rosterName,
          squads: updatedSquads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
          ruleSet: state.ruleSet,
        ),
      );
    });

    on<UpdateFactionEvent>((event, emit) {
      if (event.faction == state.selectedFaction) {
        // No change in faction, do not emit a new state
        return;
      }
      final subfaction = event.faction.subfactions.first;
      emit(
        RosterUpdated(
          playerName: state.playerName,
          rosterName: state.rosterName,
          squads: state.squads,
          selectedFaction: event.faction,
          selectedSubfaction: subfaction,
          ruleSet: getSubfactionRuleSet(subfaction),
        ),
      );
    });

    on<UpdateSubfactionEvent>((event, emit) {
      if (event.subfaction == state.selectedSubfaction) {
        // No change in subfaction, do not emit a new state
        return;
      }
      emit(
        RosterUpdated(
          playerName: state.playerName,
          rosterName: state.rosterName,
          squads: state.squads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: event.subfaction,
          ruleSet: getSubfactionRuleSet(event.subfaction),
        ),
      );
    });

    on<UpdateSquads>((event, emit) {
      emit(
        RosterUpdated(
          playerName: state.playerName,
          rosterName: state.rosterName,
          squads: event.squads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
          ruleSet: state.ruleSet,
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
          playerName: state.playerName,
          rosterName: state.rosterName,
          squads: updatedSquads,
          selectedFaction: state.selectedFaction,
          selectedSubfaction: state.selectedSubfaction,
          ruleSet: state.ruleSet,
        ),
      );
    });
  }
}
