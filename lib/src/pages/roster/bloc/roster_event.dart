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

class AddModel extends RosterEvent {
  final Squad squad;
  final Model model;

  AddModel(this.squad, this.model);
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
