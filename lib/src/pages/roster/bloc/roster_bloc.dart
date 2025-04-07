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
        state.copyWith(playerName: event.playerName),
      );
    });

    on<UpdateRosterName>((event, emit) {
      emit(state.copyWith(rosterName: event.rosterName));
    });

    on<AddSquad>((event, emit) {
      final updatedSquads = List<Squad>.from(state.squads)..add(event.squad);
      emit(state.copyWith(squads: updatedSquads));
    });

    on<AddModel>((event, emit) {
      final updatedSquads = state.squads.map((squad) {
        if (squad == event.squad) {
          return squad.copyWith(models: [...squad.models, event.model]);
        }
        return squad;
      }).toList();
      emit(state.copyWith(squads: updatedSquads));
    });

    on<UpdateFactionEvent>((event, emit) {
      if (event.faction == state.selectedFaction) {
        // No change in faction, do not emit a new state
        return;
      }
      final subfaction = event.faction.subfactions.first;
      emit(
        state.copyWith(
          squads: const [],
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
        state.copyWith(
          selectedSubfaction: event.subfaction,
          ruleSet: getSubfactionRuleSet(event.subfaction),
        ),
      );
    });

    on<UpdateSquads>((event, emit) {
      emit(
        state.copyWith(squads: event.squads),
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
        state.copyWith(squads: updatedSquads),
      );
    });
  }
}
