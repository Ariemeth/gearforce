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
}

class RosterInitial extends RosterState {
  RosterInitial()
      : super(
          playerName: '',
          rosterName: '',
          squads: const [],
          selectedFaction: Faction.blackTalons,
          selectedSubfaction: Faction.blackTalons.subfactions.first,
          ruleSet: getSubfactionRuleSet(Faction.blackTalons.subfactions.first),
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
