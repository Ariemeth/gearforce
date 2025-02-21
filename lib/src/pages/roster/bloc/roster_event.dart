part of 'roster_bloc.dart';

@immutable
abstract class RosterEvent {}

class AddCombatGroup extends RosterEvent {
  final CombatGroup combatGroup;

  AddCombatGroup(this.combatGroup);
}

class UpdatePlayerName extends RosterEvent {
  final String playerName;

  UpdatePlayerName(this.playerName);
}

class UpdateRosterName extends RosterEvent {
  final String rosterName;

  UpdateRosterName(this.rosterName);
}

class AddSquad extends RosterEvent {
  final String combatGroupId;
  final Squad squad;

  AddSquad(this.combatGroupId, this.squad);
}

class AddUnit extends RosterEvent {
  final String combatGroupId;
  final String squadId;
  final Unit unit;

  AddUnit(this.combatGroupId, this.squadId, this.unit);
}
