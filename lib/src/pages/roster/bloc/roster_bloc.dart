import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/src/models/roster/faction.dart';
import 'package:gearforce/src/models/roster/rules/rule_set.dart';
import 'package:gearforce/src/models/roster/squad.dart';
import 'package:gearforce/src/models/roster/subfaction.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:gearforce/src/predefined/rules/get_subfaction_rule_set.dart';
import 'package:meta/meta.dart';

part 'roster_event.dart';
part 'roster_state.dart';

class RosterBloc extends Bloc<RosterEvent, RosterState> {
  RosterBloc() : super(RosterInitial()) {
    on<UpdatePlayerName>((event, emit) {
      emit(state.copyWith(playerName: event.playerName));
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

    on<UpdateFaction>((event, emit) {
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
      emit(state.copyWith(squads: event.squads));
    });

    on<UpdateSquad>((event, emit) {
      final updatedSquads = state.squads.map((squad) {
        if (squad.name == event.updatedSquad.name) {
          return event.updatedSquad;
        }
        return squad;
      }).toList();
      emit(state.copyWith(squads: updatedSquads));
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

      final updatedSquads = state.squads.map((squad) {
        if (squad.name == event.squad.name) {
          return validatedSquad;
        }
        return squad;
      }).toList();

      emit(state.copyWith(squads: updatedSquads));
    });
  }
}
