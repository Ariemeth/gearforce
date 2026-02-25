part of 'roster_bloc.dart';

@immutable
sealed class RosterEvent {}

class UpdatePlayerName extends RosterEvent {
  final String playerName;

  UpdatePlayerName({required this.playerName});
}

class UpdateRosterName extends RosterEvent {
  final String rosterName;

  UpdateRosterName({required this.rosterName});
}

class UpdateFaction extends RosterEvent {
  final Faction faction;

  UpdateFaction({required this.faction});
}

class UpdateSubfaction extends RosterEvent {
  final Subfaction subfaction;

  UpdateSubfaction({required this.subfaction});
}
