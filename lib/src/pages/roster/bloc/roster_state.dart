part of 'roster_bloc.dart';

@immutable
abstract class RosterState {
  final String playerName;
  final String rosterName;
  final List<CombatGroup> combatGroups;
  final Faction? selectedFaction;
  final Subfaction? selectedSubfaction;

  const RosterState(
    this.playerName,
    this.rosterName,
    this.combatGroups, {
    this.selectedFaction,
    this.selectedSubfaction,
  });
}

class RosterInitial extends RosterState {
  RosterInitial() : super('', '', []);
}

class RosterUpdated extends RosterState {
  const RosterUpdated(
    super.playerName,
    super.rosterName,
    super.combatGroups, {
    super.selectedFaction,
    super.selectedSubfaction,
  });
}
