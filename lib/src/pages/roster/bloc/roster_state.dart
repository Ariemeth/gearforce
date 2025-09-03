part of 'roster_bloc.dart';

@immutable
abstract class RosterState {
  final String playerName;
  final String rosterName;
  final List<Squad> squads;
  final Faction selectedFaction;
  final Subfaction selectedSubfaction;
  final RuleSet ruleSet;

  const RosterState({
    required this.playerName,
    required this.rosterName,
    required this.squads,
    required this.selectedFaction,
    required this.selectedSubfaction,
    required this.ruleSet,
  });

  RosterState copyWith({
    String? playerName,
    String? rosterName,
    List<Squad>? squads,
    Faction? selectedFaction,
    Subfaction? selectedSubfaction,
    RuleSet? ruleSet,
  }) {
    return RosterUpdated(
      playerName: playerName ?? this.playerName,
      rosterName: rosterName ?? this.rosterName,
      squads: squads ?? this.squads,
      selectedFaction: selectedFaction ?? this.selectedFaction,
      selectedSubfaction: selectedSubfaction ?? this.selectedSubfaction,
      ruleSet: ruleSet ?? this.ruleSet,
    );
  }
}

class RosterInitial extends RosterState {
  RosterInitial()
    : super(
        playerName: '',
        rosterName: '',
        squads: const [],
        // TODO Set this back to blacktalons when everything is ready
        selectedFaction: Faction.north,
        selectedSubfaction: Faction.north.subfactions.first,
        ruleSet: getSubfactionRuleSet(Faction.north.subfactions.first),
      );
}

class RosterUpdated extends RosterState {
  const RosterUpdated({
    required super.playerName,
    required super.rosterName,
    required super.squads,
    required super.selectedFaction,
    required super.selectedSubfaction,
    required super.ruleSet,
  });
}
