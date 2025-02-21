part of 'roster_bloc.dart';

@immutable
abstract class RosterState {
  final String playerName;
  final String rosterName;
  final List<CombatGroup> combatGroups;

  const RosterState(this.playerName, this.rosterName, this.combatGroups);
}

class RosterInitial extends RosterState {
  RosterInitial() : super('', '', []);
}

class RosterUpdated extends RosterState {
  const RosterUpdated(super.playerName, super.rosterName, super.combatGroups);
}
