part of 'roster_bloc.dart';

@immutable
sealed class RosterState {
  final String playerName;
  final String rosterName;
  final SquadState squadState;
  final Faction selectedFaction;
  final Subfaction selectedSubfaction;
  final RuleSet ruleSet;

  const RosterState({
    required this.playerName,
    required this.rosterName,
    required this.squadState,
    required this.selectedFaction,
    required this.selectedSubfaction,
    required this.ruleSet,
  });

  RosterState copyWith({
    String? playerName,
    String? rosterName,
    SquadState? squadState,
    Faction? selectedFaction,
    Subfaction? selectedSubfaction,
    RuleSet? ruleSet,
  }) {
    return RosterUpdated(
      playerName: playerName ?? this.playerName,
      rosterName: rosterName ?? this.rosterName,
      squadState: squadState ?? this.squadState,
      selectedFaction: selectedFaction ?? this.selectedFaction,
      selectedSubfaction: selectedSubfaction ?? this.selectedSubfaction,
      ruleSet: ruleSet ?? this.ruleSet,
    );
  }

  List<Squad> get squads => squadState.squads;
}

class RosterInitial extends RosterState {
  RosterInitial(UnitRepository unitRepository)
    : super(
        playerName: '',
        rosterName: '',
        squadState: const SquadState(squads: []),
        // TODO Set this back to blacktalons when everything is ready
        selectedFaction: Faction.north,
        selectedSubfaction: Faction.north.subfactions.first,
        ruleSet: getSubfactionRuleSet(
          Faction.north.subfactions.first,
          unitRepository,
        ),
      );
}

class RosterUpdated extends RosterState {
  const RosterUpdated({
    required super.playerName,
    required super.rosterName,
    required super.squadState,
    required super.selectedFaction,
    required super.selectedSubfaction,
    required super.ruleSet,
  });
}
