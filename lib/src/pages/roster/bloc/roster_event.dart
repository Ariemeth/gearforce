part of 'roster_bloc.dart';

@immutable
abstract class RosterEvent {}

class UpdatePlayerName extends RosterEvent {
  final String playerName;

  UpdatePlayerName(this.playerName);
}

class UpdateRosterName extends RosterEvent {
  final String rosterName;

  UpdateRosterName(this.rosterName);
}

class AddSquad extends RosterEvent {
  final Squad squad;

  AddSquad(this.squad);
}

class AddUnit extends RosterEvent {
  final String squadName; // Renamed from squadId to squadName
  final CoreUnit unit;

  AddUnit(this.squadName, this.unit); // Updated parameter name
}

class UpdateFactionEvent extends RosterEvent {
  final Faction faction;

  UpdateFactionEvent(this.faction);
}

class UpdateSubfactionEvent extends RosterEvent {
  final Subfaction subfaction;

  UpdateSubfactionEvent(this.subfaction);
}

class UpdateSquads extends RosterEvent {
  final List<Squad> squads;

  UpdateSquads(this.squads);
}

class UpdateSquad extends RosterEvent {
  final Squad updatedSquad;

  UpdateSquad(this.updatedSquad);
}
