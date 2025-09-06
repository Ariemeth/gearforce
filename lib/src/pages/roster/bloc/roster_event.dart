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

// class AddSquad extends RosterEvent {
//   final Squad squad;
//
//   AddSquad({required this.squad});
// }
//
// class AddModel extends RosterEvent {
//   final Squad squad;
//   final Model model;
//
//   AddModel({required this.squad, required this.model});
// }

class UpdateFaction extends RosterEvent {
  final Faction faction;

  UpdateFaction({required this.faction});
}

class UpdateSubfaction extends RosterEvent {
  final Subfaction subfaction;

  UpdateSubfaction({required this.subfaction});
}

// class UpdateSquads extends RosterEvent {
//   final List<Squad> squads;
//
//   UpdateSquads({required this.squads});
// }
//
// class UpdateSquad extends RosterEvent {
//   final Squad updatedSquad;
//
//   UpdateSquad({required this.updatedSquad});
// }
//
// class UpdateSquadRoles extends RosterEvent {
//   final Squad squad;
//   final Role primaryRole;
//   final Role? secondaryRole;
//
//   UpdateSquadRoles({
//     required this.squad,
//     required this.primaryRole,
//     this.secondaryRole,
//   });
// }
